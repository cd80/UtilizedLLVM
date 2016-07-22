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

			// prerequisites for const_ptr_10
			PointerType* PointerTy_3 = PointerType::get(IntegerType::get(mod->getContext(), 8), 0);
			std::vector<Type*>FuncTy_5_args;
			FuncTy_5_args.push_back(PointerTy_3);
			FunctionType* FuncTy_5 = FunctionType::get(/*Result=*/IntegerType::get(mod->getContext(), 32),
														/*Params=*/FuncTy_5_args,
														/*isVarArg=*/true);
			PointerType* PointerTy_4 = PointerType::get(FuncTy_5, 0);
			Constant* const_ptr_10 = ConstantExpr::getCast(Instruction::BitCast, func_puts, PointerTy_4);

			// prerequisites for const_ptr_8
			char *msg;
			asprintf(&msg, "Executing: %s", F.getName().bytes_begin());
			
			ArrayType* ArrayTy_0 = ArrayType::get(IntegerType::get(mod->getContext(), 8), strlen(msg)+1);
			GlobalVariable* gvar_array__str = new GlobalVariable(/*Module=*/*mod,
																/*Type=*/ArrayTy_0,
																/*isConstant=*/true,
																/*Linkage=*/GlobalValue::PrivateLinkage,
																/*Initializer=*/0, // has initializer, specified below
																/*Name=*/".str");
			gvar_array__str->setAlignment(1);

			Constant *const_array_7 = ConstantDataArray::getString(mod->getContext(), msg, true);
			std::vector<Constant*> const_ptr_8_indices;
			ConstantInt* const_int32_9 = ConstantInt::get(mod->getContext(), APInt(32, StringRef("0"), 10));
			const_ptr_8_indices.push_back(const_int32_9);
			const_ptr_8_indices.push_back(const_int32_9);
			Constant* const_ptr_8 = ConstantExpr::getGetElementPtr(0, gvar_array__str, const_ptr_8_indices);
			gvar_array__str->setInitializer(const_array_7);

			CallInst* int32_call = CallInst::Create(const_ptr_10, const_ptr_8, "call");
			int32_call->setCallingConv(CallingConv::C);
			int32_call->setTailCall(false);
			AttributeSet int32_call_PAL;
			int32_call->setAttributes(int32_call_PAL);

			F.getEntryBlock().getInstList().push_front(int32_call);
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
