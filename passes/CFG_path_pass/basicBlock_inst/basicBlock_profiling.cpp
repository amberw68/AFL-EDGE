#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instruction.h"
#include "llvm/MC/MCInstrAnalysis.h"
#include "llvm/MC/MCInstrDesc.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/None.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/Statepoint.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include <cassert>
#include <cstdint>
#include <vector>
#include <utility>
#include <string>
#include <map>
#include "llvm/IR/Dominators.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/Analysis/MemoryDependenceAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Support/GenericDomTree.h"
#include <typeinfo>
#include "llvm/Analysis/Interval.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/Support/Debug.h"
#include "llvm/IR/InstIterator.h"
#include "llvm-c/Core.h"
#include <iostream>
#include <list>
#include <iterator>
#include <set>
#include <chrono>
#include <ctime>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;
using namespace std;

namespace llvm{

	struct iterateAllBB : public ModulePass{
		Function *printFunction;
		public : 
			static char ID;
			iterateAllBB():ModulePass(ID){}
			virtual bool runOnModule(Module &M)override;
	};
}

bool iterateAllBB::runOnModule(Module &M){

	LLVMContext &context = M.getContext();
	IntegerType *Int32Ty = IntegerType::getInt32Ty(context);
    Type *VoidTy = Type::getVoidTy(M.getContext());
    Constant *printCons = M.getOrInsertFunction("PrintSth_num", VoidTy, Int32Ty, Int32Ty);
    printFunction = cast<Function>(printCons);

    GlobalVariable *AFLPrevLoc = new GlobalVariable(/*Module=*/M, 
        /*Type=*/Int32Ty,
        /*isConstant=*/false,
        /*Linkage=*/GlobalValue::ExternalLinkage,
        /*Initializer=*/0, // has initializer, specified below
        /*Name=*/"Bbprofile_prev_loc");

    // GlobalVariable *AFLPrevLoc = new GlobalVariable(M, Int32Ty, false, GlobalValue::ExternalLinkage, 0, "__afl_prev_loc", 0, GlobalVariable::GeneralDynamicTLSModel, 0, false);
	for(auto &F:M){
		for(auto &BB:F){
      		BasicBlock::iterator IP = BB.getFirstInsertionPt();
      		IRBuilder<> IRB(&(*IP));
      		/* Make up cur_loc */

      		unsigned int cur_loc = rand();
      		ConstantInt *CurLoc = ConstantInt::get(Int32Ty, cur_loc);
      		
      		LoadInst *PrevLoc = IRB.CreateLoad(AFLPrevLoc);
      		//PrevLoc->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(C, None));
      		Value *PrevLocCasted = IRB.CreateZExt(PrevLoc, IRB.getInt32Ty());

      		// Value *strPtr = IRB.CreateGlobalStringPtr(CurLoc);
      		std::vector<Value*> args;
			args.push_back(CurLoc);
			args.push_back(PrevLocCasted);

			CallInst *printCall = IRB.CreateCall(printFunction, args);

      		/* Set prev_loc to cur_loc >> 1 */
      		StoreInst *Store = IRB.CreateStore(ConstantInt::get(Int32Ty, cur_loc >> 1), AFLPrevLoc);
      		//Store->setMetadata(M.getMDKindID("nosanitize"), MDNode::get(context, None));
		}
	}

	return true;
}


char iterateAllBB::ID = 0;
static RegisterPass<iterateAllBB> X1("iterateAllBB", "get all BB unique number");