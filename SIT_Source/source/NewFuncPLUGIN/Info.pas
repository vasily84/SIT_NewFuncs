
{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

unit Info;

//**************************************************************************//
// Данный исходный код является составной частью системы SimInTech          //
// Авторские права на данный код принадлежат ООО 3В-Сервис                  //
//       Авторы: Тимофеев К.А.,                                             //
//**************************************************************************//

interface

uses
  Classes,
  DataTypes,
  InterfaceUnit;

// Инициализация библиотеки
function  Init(): Boolean;
// Процедура создания объекта
function  CreateObject(Owner:Pointer;const Name: string):Pointer;
// Уничтожение библиотеки
procedure Release;

// Главная информационая запись библиотеки
// Она содержит ссылки на процедуры инициализации, завершения библиотеки
// и функцию создания объектов
const
  DllInfo: TDllInfo =
  (
    Init:         Init;
    Release:      Release;
    CreateObject: CreateObject;
  );


implementation

uses  uNewFunctions;

function  Init(): Boolean;
begin
  // Если библиотека инициализирована правильно, то функция должна вернуть True
  Result := True;
  // Присваиваем папку с корневой директорией базы данных программы
  DBRoot := DllInfo.Main^.DataBasePath^;
  // Регистрируем функции для доступа к ним из проектов
  DllInfo.Main^.RegisterFuncs(@NewFuncs, Length(NewFuncs));
end;

// Процедура создания объектов
// Возвращает интерфейс объекту-плагину
function  CreateObject(Owner:Pointer; const Name: String): Pointer;
begin
  Result := nil;
end;

procedure Release;
begin

end;


end.
