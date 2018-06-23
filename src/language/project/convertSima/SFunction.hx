package language.project.convertSima ;
	import language.enumeration.EuFuncType;
	import language.enumeration.EuLocation;
	import language.enumeration.EuVarType;
	import language.enumeration.EuSharing;
	import language.project.convertCpp.TypeText;
	import language.vars.varObj.CommonVar;
	import language.vars.varObj.PtrFunc;
	import language.vars.varObj.VarObj;
	import language.base.Root;
	/**
	 * ...
	 * @author ...
	 */
	class SFunction extends SBloc
	{
		
		public var bSpecifiquePlatforme : Bool = false;
		public var bSpecialGenerate : Bool = false;
		
		public var bConstructor : Bool = false;
		public var bDefaultConstructor : Bool = false;
		public var eSharing : EuSharing;
		public var bOverable : Bool = true;
		public var eFuncType : EuFuncType;
		public var bStatic : Bool = false;  //linked with EuFuncType.Static; better algo ==>	if (_bStatic == _oFunc.bStatic) {
		public var bAddDlgWrapper : Bool = false;  

		public var bRemoveStaticClass : Bool = false; //Only cpp convertion
		public var bConvNewName  : Bool = false; //Only cpp convertion
		public var sConvNewName : String = ""; //Only cpp convertion
		
		public var bNoLine : Bool = false;
		
		public var nLineNum : UInt;
		
		public var sName : String;

		public var aAllVarList : Array<Dynamic> = [];
		public var aAddRefParamU : Array<Dynamic> = [];

		
		public var aParamList : Array<Dynamic> = [];
		public var aParamTypeList : Array<Dynamic> = [];
		public var aParamNotIni : Array<Dynamic> = [];
		public var sReturnNotIni : String;
		
		public var oReturn : CommonVar;
		
		public var aLineReturnList : Array<Dynamic> = [];
		
		public var sIniReturn : String;
		public var bMacro : Bool = false;
		
		public var sDelegateString : String;
		
		//public var oSClass :SClass
		
		
		
		public function new(_Main:Root, _oSClass : SClass) {
			if(_oSClass != null){
				oSClass = _oSClass;
				oSFunction = this;
				oParentBloc = null;
				oSClass.aFunctionList.push(this);
				super(null);
				eType = EuVarType._Function;
				
				var _oPtrFunc : PtrFunc =  new PtrFunc(_oSClass, this);
				oSClass.aPtrFuncList.push(_oPtrFunc);

			}
		}


		override private function pushChildBlocVar(_aVar : VarObj):Void {
			
			aAllVarList.push(_aVar);
		} 
		
		
		public function pushParam(_oVar : VarObj):Void { 
			aParamList.push(_oVar);
			aParamTypeList.push(_oVar.eType);
			if (TypeResolve.isVarCommon(_oVar)) {
				cast(_oVar,CommonVar).eLocation = EuLocation.Param;
				
			}
			if(aVarList != null){
				aVarList.push(_oVar);
			}
			////////// Intelli ptr /////
			switch(_oVar.eType) {
				case EuVarType._Rtu:
					aAddRefParamU.push(_oVar);
				//break;
				default:
			}
		} 
		

		
	
		public function getDelegateString():String { 
			if (sDelegateString == null) {
				sDelegateString = SDelegate.createDelegateString(oReturn, aParamList);
			}
			return sDelegateString;
		}
		
			
	}

