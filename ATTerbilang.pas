unit ATTerbilang;
{ Component   : ATTerbilang
  Version     : 1.05
  Coder       : Sony Arianto K
  Copyright © June, 1998 AriTech Development Indonesia
  E-Mail      : sony-ak@programmer.net
  Web site    : http://www.geocities.com/Pentagon/5900/
  Made in Indonesia
  History     :
  Version 1.00    - First release
  Version 1.05    - Redesign component, now bug free !! Test it !!

  Version 2 : Decimal value support; by Lucky Vic luckynvic@gmail.com
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TATTerbilang = class(TComponent)
  private
    NullValS: string;
    FAuthor: string;
    FNumber: Int64;
    FDecimal: integer;
    FDecimalNumber: integer;
    FValue: Currency;
    procedure SetNumber(value: Int64);
    procedure SetDecimal(value: integer);
    procedure SetValue(value: Currency);
    function GetTerbilang: string;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DecimalNumber: integer read FDecimalNumber write FDecimalNumber;
    property Author: string read FAuthor write NullValS;
    property Number: Int64 read FNumber write SetNumber;
    property Decimal: integer read FDecimal write SetDecimal;
    property value: Currency read FValue write SetValue;
    property Terbilang: string read GetTerbilang write NullValS;
  end;

procedure Register;

implementation

const
  Satu = 'satu ';
  Nol = 'nol ';
  Belas = 'belas ';
  Angka: array [1 .. 9] of string = ('se', 'dua ', 'tiga ', 'empat ', 'lima ',
    'enam ', 'tujuh ', 'delapan ', 'sembilan ');
  Satuan3: array [1 .. 2] of string = ('ratus ', 'puluh ');
  Satuan: array [0 .. 4] of string = ('', 'ribu ', 'juta ', 'milyar ',
    'triliyun ');

function TATTerbilang.GetTerbilang: string;
var
  tmp, tmp2: string;
  TStr: TStringList;
  i, j: integer;
begin
  TStr := TStringList.Create;
  tmp := format('%0.0n', [strtofloat(inttostr(FNumber))]) + ThousandSeparator;
  while tmp <> '' do
  begin
    TStr.Insert(0, copy(tmp, 1, pos(ThousandSeparator, tmp) - 1));
    delete(tmp, 1, pos(ThousandSeparator, tmp));
  end;
  for i := 0 to TStr.Count - 1 do
    TStr.Strings[i] := format('%0.3d', [strtoint(TStr.Strings[i])]);
  for i := TStr.Count - 1 downto 0 do
  begin
    tmp := TStr.Strings[i];
    for j := 1 to 3 do
    begin
      if tmp[j] = '0' then
        continue;
      case j of
        1:
          if tmp[j] <> '0' then
            tmp2 := tmp2 + Angka[strtoint(tmp[j])] + Satuan3[j];
        2:
          case tmp[j] of
            '1':
              begin
                case tmp[j + 1] of
                  '0':
                    tmp2 := tmp2 + Angka[strtoint(tmp[j])] + Satuan3[j];
                  '1' .. '9':
                    tmp2 := tmp2 + Angka[strtoint(tmp[j + 1])] + Belas;
                end;
                break;
              end;
            '2' .. '9':
              tmp2 := tmp2 + Angka[strtoint(tmp[j])] + Satuan3[j];
          end;
        3:
          case tmp[j] of
            '1':
              case FNumber of
                1:
                  tmp2 := tmp2 + Satu;
                1000 .. 1999:
                  if i = 0 then
                    tmp2 := tmp2 + Satu
                  else
                    tmp2 := tmp2 + Angka[strtoint(tmp[j])];
              else
                tmp2 := tmp2 + Satu;
              end;
          else
            tmp2 := tmp2 + Angka[strtoint(tmp[j])];
          end;
      end;
    end;
    if strtoint(tmp) <> 0 then
      tmp2 := tmp2 + Satuan[i];
  end;

  // decimal value;
  if FDecimalNumber > 0 then
  begin
    if FNumber = 0 then
      tmp2 := Nol;
    tmp2 := tmp2 + 'koma ';
    tmp := copy(inttostr(FDecimal) + stringOfChar('0', FDecimalNumber), 1,
      FDecimalNumber);

    for i := 1 to length(tmp) do
    begin
      case tmp[i] of
        '0':
          tmp2 := tmp2 + Nol;
        '1':
          tmp2 := tmp2 + Satu;
      else
        tmp2 := tmp2 + Angka[strtoint(tmp[i])];
      end;
    end;

  end;

  TStr.Free;
  result := Trim(tmp2);
end;

procedure TATTerbilang.SetNumber(value: Int64);
begin
  if value <> FNumber then
    FNumber := value;
end;

procedure TATTerbilang.SetDecimal(value: integer);
begin
  if value <> FDecimal then
    FDecimal := value;
end;

procedure TATTerbilang.SetValue(value: Currency);
begin
  if value <> FValue then
  begin
    FValue := value;
    FDecimal := round(frac(value) * (FDecimalNumber * 10));
    FNumber := trunc(value);
  end;
end;

constructor TATTerbilang.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAuthor := 'Sony Arianto K of AriTech Development [June,1998]';
  FNumber := 0;
  FValue := 0;
  FDecimalNumber := 0;
  FDecimal := 0;
end;

destructor TATTerbilang.Destroy;
begin
  inherited;
end;

procedure Register;
begin
  RegisterComponents('AriTech', [TATTerbilang]);
end;

end.
