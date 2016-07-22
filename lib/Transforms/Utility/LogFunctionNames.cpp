#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Type.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/CodeGen/ISDOpcodes.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Transforms/IPO.h"
#include <list>

#include "llvm/Transforms/Utility/LogFunctionNames.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Linker/Linker.h"
#include "llvm/Support/SourceMgr.h"
using namespace llvm;
namespace {
	struct LogFunctionNames : public FunctionPass {
		static char ID; // Pass identification
		bool flag;
		LogFunctionNames() : FunctionPass(ID) {}
		LogFunctionNames(bool flag) : FunctionPass(ID) {this->flag = flag; LogFunctionNames();}

		virtual bool runOnFunction(Function &F){
			errs() << "Current function name: [" << F.getName() << "]\n";
			errs() << "Current module name: [" << F.getParent()->getName() << "]\n";
			Module *mod = F.getParent();
			std::vector<Type*>FuncTy_6_args;
			FunctionType* FuncTy_6 = FunctionType::get(/*Result=*/IntegerType::get(mod->getContext(), 32),
														/*Params=*/FuncTy_6_args,
														/*isVarArg=*/true);
			Function* func_puts = mod->getFunction("puts");
			if (!func_puts) {
				func_puts = Function::Create(/*Type=*/FuncTy_6,
											/*Linkage=*/GlobalValue::ExternalLinkage,
											/*Name=*/"puts", mod); // (external, no body)
				func_puts->setCallingConv(CallingConv::C);
			}
			AttributeSet func_puts_PAL;
			{
				SmallVector<AttributeSet, 4> Attrs;
				AttributeSet PAS;
				{
					AttrBuilder B;
					PAS = AttributeSet::get(mod->getContext(), ~0U, B);
				}
				Attrs.push_back(PAS);
				func_puts_PAL = AttributeSet::get(mod->getContext(), Attrs);
			}
			func_puts->setAttributes(func_puts_PAL);
			return false;
		}
	};
}

char LogFunctionNames::ID = 0;
static RegisterPass<LogFunctionNames> X("logger", "inserting logging routine for functions");

Pass *llvm::createLogger() {
	return new LogFunctionNames();
}

Pass *llvm::createLogger(bool flag) {
	return new LogFunctionNames(flag);
}
