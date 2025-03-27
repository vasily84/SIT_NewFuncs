unit uNewFunctions;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses DataTypes, FuncTypes, SysUtils;
function diffxy_info(Sender: TOpContainer;Action: NativeInt;ArgIndex: NativeInt;IsAssign: boolean;var Params:TInfoParams):NativeInt;
function diffxy_run(Sender: TCustomFunc):NativeInt;

const

 //  Функции для встроенного скриптового языка для работы
 NewFuncs : array [0..0] of TFuncInfo = (
   (Name:'diffxy';RunFunc:diffxy_run;     InfoFunc:diffxy_info)
 );

implementation

function diffxy_info(Sender: TOpContainer;Action: NativeInt;ArgIndex: NativeInt;IsAssign: boolean;var Params:TInfoParams):NativeInt;
begin
 Result:=0;
 case Action of
   a_GetArgCount: Result:=2;
   a_GetArgType:  case ArgIndex of
                    0,1: Result:=dtDoubleArray;
                  else
                    Result:=dtInteger;
                  end;
   a_GetResType:  Result:=dtDoubleArray;
 end;
end;

function diffxy_run(Sender: TCustomFunc):NativeInt;
// построить конечную разность.
// вход - x_arr = […];y_arr = […]; -массивы
// выход y_dot_arr = func(x_arr, y_arr); - массив
// длина выхода = [минимальная] длина входного массива -1.
var
  i,nCounts:Integer;
  dx,dy,s:RealType;
  argX, argY, resultArr:TExtArray;
begin
  Result:=0;
  resultArr:=TExtArray(Sender.Data);
  argX:=TExtArray(Sender.Args[0].Data);
  argY:=TExtArray(Sender.Args[1].Data);

  nCounts := argX.Count;
  if nCounts> argY.Count then nCounts := argY.Count;

  resultArr.Count:=nCounts-1;

  for i:=0 to nCounts-2 do begin
    dx:=argX[i+1]-argX[i];
    dy:=argY[i+1]-argY[i];
    s:=dy/dx;
    resultArr.Arr[i]:=s;
    end;

end;

end.
