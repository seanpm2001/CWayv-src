package language.vars.varObj ;
	import language.enumeration.EuLocation;
	import language.enumeration.EuVarType;
	import language.project.convertSima.SBloc;
	import language.project.convertSima.SClass;
	import language.project.convertSima.SFind;
	import language.project.convertSima.TypeResolve;

	

	class VarObj  {
		
			public function new() {}
		
		//public var eType : UInt;
		public var eType : EuVarType;
		
		public function fGetType(_eOpt:UInt = 0):String {
			return "NI";
		}
		
		 //Override
		public function copy(_SBloc:SBloc):VarObj {
			return null;
		}

		public function copyArrayVars(_aList:Array<Dynamic>, _oSBloc:SBloc):Array<Dynamic> {
			var _aCopy : Array<Dynamic> = [];
			var _oVarCopy : VarObj;
			var _i:UInt = _aList.length;
			for (i in 0 ..._i) {
				var _oVarSel : VarObj = _aList[i];
				
				_oVarCopy = getInstanceOrCopieVar(_oSBloc, _oVarSel); 
				
				if(_oVarCopy != null){
					_aCopy.push(_oVarCopy);
				}else {
					_aCopy.push(EuVar.VarNone); //Error ???
				}
			}
			return _aCopy;
		}
		
	
		
		public function getInstanceOrCopieVar(_oSBloc:SBloc, _oVarSel:VarObj):VarObj {
				
				if(TypeResolve.isVarCommon(_oVarSel) ){
					var _oVar : CommonVar = cast(_oVarSel);
					switch(_oVar.eLocation) {
						case EuLocation.Param :
							return SFind.getParamInCopy(_oSBloc, _oVar);
						//break;
						default:
						
					}
				}

					
				switch(_oVarSel.eType) {
					
					default:
				}
				
				
				return  _oVarSel.copy(_oSBloc);
			}
		
		
	

	}
