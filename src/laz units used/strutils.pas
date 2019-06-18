{
    Delphi/Kylix compatibility unit: String handling routines.

    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2005 by the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$mode objfpc}
{$h+}
{$inline on}
unit strutils;

interface

uses
  SysUtils{, Types};

{ ---------------------------------------------------------------------
    Case insensitive search/replace
  ---------------------------------------------------------------------}

Function AnsiResemblesText(const AText, AOther: string): Boolean;
Function AnsiContainsText(const AText, ASubText: string): Boolean;
Function AnsiStartsText(const ASubText, AText: string): Boolean;
Function AnsiEndsText(const ASubText, AText: string): Boolean;
Function AnsiReplaceText(const AText, AFromText, AToText: string): string;inline;
Function AnsiMatchText(const AText: string; const AValues: array of string): Boolean;inline;
Function AnsiIndexText(const AText: string; const AValues: array of string): Integer;

{ ---------------------------------------------------------------------
    Case sensitive search/replace
  ---------------------------------------------------------------------}

Function AnsiContainsStr(const AText, ASubText: string): Boolean;inline;
Function AnsiStartsStr(const ASubText, AText: string): Boolean;
Function AnsiEndsStr(const ASubText, AText: string): Boolean;
Function AnsiReplaceStr(const AText, AFromText, AToText: string): string;inline;
Function AnsiMatchStr(const AText: string; const AValues: array of string): Boolean;inline;
Function AnsiIndexStr(const AText: string; const AValues: array of string): Integer;
Function MatchStr(const AText: UnicodeString; const AValues: array of UnicodeString): Boolean;
Function IndexStr(const AText: UnicodeString; const AValues: array of UnicodeString): Integer;

{ ---------------------------------------------------------------------
    Miscellaneous
  ---------------------------------------------------------------------}

Function DupeString(const AText: string; ACount: Integer): string;
Function ReverseString(const AText: string): string;
Function AnsiReverseString(const AText: AnsiString): AnsiString;inline;
Function StuffString(const AText: string; AStart, ALength: Cardinal;  const ASubText: string): string;
Function RandomFrom(const AValues: array of string): string; overload;
Function IfThen(AValue: Boolean; const ATrue: string; const AFalse: string = ''): string; overload;
function NaturalCompareText (const S1 , S2 : string ): Integer ;
function NaturalCompareText(const Str1, Str2: string; const ADecSeparator, AThousandSeparator: Char): Integer;

{ ---------------------------------------------------------------------
    VB emulations.
  ---------------------------------------------------------------------}

Function LeftStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;inline;
Function RightStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;
Function MidStr(const AText: AnsiString; const AStart, ACount: SizeInt): AnsiString;inline;
Function RightBStr(const AText: AnsiString; const AByteCount: SizeInt): AnsiString;inline;
Function MidBStr(const AText: AnsiString; const AByteStart, AByteCount: SizeInt): AnsiString;inline;
Function AnsiLeftStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;inline;
Function AnsiRightStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;inline;
Function AnsiMidStr(const AText: AnsiString; const AStart, ACount: SizeInt): AnsiString;inline;
Function LeftBStr(const AText: AnsiString; const AByteCount: SizeInt): AnsiString;inline;
Function LeftStr(const AText: WideString; const ACount: SizeInt): WideString;inline;
Function RightStr(const AText: WideString; const ACount: SizeInt): WideString;
Function MidStr(const AText: WideString; const AStart, ACount: SizeInt): WideString;inline;

{ ---------------------------------------------------------------------
    Extended search and replace
  ---------------------------------------------------------------------}

const
  { Default word delimiters are any character except the core alphanumerics. }
  WordDelimiters: set of Char = [#0..#255] - ['a'..'z','A'..'Z','1'..'9','0'];
  
resourcestring
  SErrAmountStrings        = 'Amount of search and replace strings don''t match';

type
  TStringSearchOption = (soDown, soMatchCase, soWholeWord);
  TStringSearchOptions = set of TStringSearchOption;
  TStringSeachOption = TStringSearchOption;

Function SearchBuf(Buf: PChar; BufLen: SizeInt; SelStart, SelLength: SizeInt; SearchString: String; Options: TStringSearchOptions): PChar;
Function SearchBuf(Buf: PChar; BufLen: SizeInt; SelStart, SelLength: SizeInt; SearchString: String): PChar;inline; // ; Options: TStringSearchOptions = [soDown]
Function PosEx(const SubStr, S: string; Offset: SizeUint): SizeInt;
Function PosEx(const SubStr, S: string): SizeInt;inline; // Offset: Cardinal = 1
Function PosEx(c:char; const S: string; Offset: SizeUint): SizeInt;
Function PosEx(const SubStr, S: UnicodeString; Offset: SizeUint): SizeInt;
Function PosEx(c: WideChar; const S: UnicodeString; Offset: SizeUint): SizeInt;
Function PosEx(const SubStr, S: UnicodeString): Sizeint;inline; // Offset: Cardinal = 1
function StringsReplace(const S: string; OldPattern, NewPattern: array of string;  Flags: TReplaceFlags): string;

{ ---------------------------------------------------------------------
    Delphi compat
  ---------------------------------------------------------------------}

Function ReplaceStr(const AText, AFromText, AToText: string): string;inline;
Function ReplaceText(const AText, AFromText, AToText: string): string;inline;

{ ---------------------------------------------------------------------
    Soundex Functions.
  ---------------------------------------------------------------------}

type
  TSoundexLength = 1..MaxInt;

Function Soundex(const AText: string; ALength: TSoundexLength): string;
Function Soundex(const AText: string): string;inline; // ; ALength: TSoundexLength = 4

type
  TSoundexIntLength = 1..8;

Function SoundexInt(const AText: string; ALength: TSoundexIntLength): Integer;
Function SoundexInt(const AText: string): Integer;inline; //; ALength: TSoundexIntLength = 4
Function DecodeSoundexInt(AValue: Integer): string;
Function SoundexWord(const AText: string): Word;
Function DecodeSoundexWord(AValue: Word): string;
Function SoundexSimilar(const AText, AOther: string; ALength: TSoundexLength): Boolean;inline;
Function SoundexSimilar(const AText, AOther: string): Boolean;inline; //; ALength: TSoundexLength = 4
Function SoundexCompare(const AText, AOther: string; ALength: TSoundexLength): Integer;inline;
Function SoundexCompare(const AText, AOther: string): Integer;inline; //; ALength: TSoundexLength = 4
Function SoundexProc(const AText, AOther: string): Boolean;

type
  TCompareTextProc = Function(const AText, AOther: string): Boolean;

Const
  AnsiResemblesProc: TCompareTextProc = @SoundexProc;

{ ---------------------------------------------------------------------
    Other functions, based on RxStrUtils.
  ---------------------------------------------------------------------}
type
 TRomanConversionStrictness = (rcsStrict, rcsRelaxed, rcsDontCare);

resourcestring
  SInvalidRomanNumeral = '%s is not a valid Roman numeral';

function IsEmptyStr(const S: string; const EmptyChars: TSysCharSet): Boolean;
function DelSpace(const S: string): string;
function DelChars(const S: string; Chr: Char): string;
function DelSpace1(const S: string): string;
function Tab2Space(const S: string; Numb: Byte): string;
function NPos(const C: string; S: string; N: Integer): SizeInt;
Function RPosEX(C:char;const S : AnsiString;offs:cardinal):SizeInt; overload;
Function RPosex (Const Substr : AnsiString; Const Source : AnsiString;offs:cardinal) : SizeInt; overload;
Function RPos(c:char;const S : AnsiString):SizeInt; overload;
Function RPos (Const Substr : AnsiString; Const Source : AnsiString) : SizeInt; overload;
function AddChar(C: Char; const S: string; N: Integer): string;
function AddCharR(C: Char; const S: string; N: Integer): string;
function PadLeft(const S: string; N: Integer): string;inline;
function PadRight(const S: string; N: Integer): string;inline;
function PadCenter(const S: string; Len: SizeInt): string;
function Copy2Symb(const S: string; Symb: Char): string;
function Copy2SymbDel(var S: string; Symb: Char): string;
function Copy2Space(const S: string): string;inline;
function Copy2SpaceDel(var S: string): string;inline;
function AnsiProperCase(const S: string; const WordDelims: TSysCharSet): string;
function WordCount(const S: string; const WordDelims: TSysCharSet): SizeInt;
function WordPosition(const N: Integer; const S: string; const WordDelims: TSysCharSet): SizeInt;
function ExtractWord(N: Integer; const S: string;  const WordDelims: TSysCharSet): string;inline;
{$IF SIZEOF(SIZEINT)<>SIZEOF(INTEGER)}
function ExtractWordPos(N: Integer; const S: string; const WordDelims: TSysCharSet; out Pos: SizeInt): string;
{$ENDIF}
function ExtractWordPos(N: Integer; const S: string; const WordDelims: TSysCharSet; out Pos: Integer): string;
function ExtractDelimited(N: Integer; const S: string;  const Delims: TSysCharSet): string;
{$IF SIZEOF(SIZEINT)<>SIZEOF(INTEGER)}
function ExtractSubstr(const S: string; var Pos: SizeInt;  const Delims: TSysCharSet): string;
{$ENDIF}
function ExtractSubstr(const S: string; var Pos: Integer;  const Delims: TSysCharSet): string;
function IsWordPresent(const W, S: string; const WordDelims: TSysCharSet): Boolean;
function FindPart(const HelpWilds, InputStr: string): SizeInt;
function IsWild(InputStr, Wilds: string; IgnoreCase: Boolean): Boolean;
function XorString(const Key, Src: ShortString): ShortString;
function XorEncode(const Key, Source: string): string;
function XorDecode(const Key, Source: string): string;
function GetCmdLineArg(const Switch: string; SwitchChars: TSysCharSet): string;
function Numb2USA(const S: string): string;
function Hex2Dec(const S: string): Longint;
function Dec2Numb(N: Longint; Len, Base: Byte): string;
function Numb2Dec(S: string; Base: Byte): Longint;
function IntToBin(Value: Longint; Digits, Spaces: Integer): string;
function IntToBin(Value: Longint; Digits: Integer): string;
function intToBin(Value: int64; Digits:integer): string;
function IntToRoman(Value: Longint): string;
function TryRomanToInt(S: String; out N: LongInt; Strictness: TRomanConversionStrictness = rcsRelaxed): Boolean;
function RomanToInt(const S: string; Strictness: TRomanConversionStrictness = rcsRelaxed): Longint;
function RomanToIntDef(Const S : String; const ADefault: Longint = 0; Strictness: TRomanConversionStrictness = rcsRelaxed): Longint;
procedure BinToHex(BinValue, HexValue: PChar; BinBufSize: Integer);
function HexToBin(HexValue, BinValue: PChar; BinBufSize: Integer): Integer;

const
  DigitChars = ['0'..'9'];
  Brackets = ['(',')','[',']','{','}'];
  StdWordDelims = [#0..' ',',','.',';','/','\',':','''','"','`'] + Brackets;
  StdSwitchChars = ['-','/'];

function PosSet (const c:TSysCharSet;const s : ansistring ):SizeInt;
function PosSet (const c:string;const s : ansistring ):SizeInt;
function PosSetEx (const c:TSysCharSet;const s : ansistring;count:Integer ):SizeInt;
function PosSetEx (const c:string;const s : ansistring;count:Integer ):SizeInt;

Procedure Removeleadingchars(VAR S : AnsiString; Const CSet:TSysCharset);
Procedure RemoveTrailingChars(VAR S : AnsiString;Const CSet:TSysCharset);
Procedure RemovePadChars(VAR S : AnsiString;Const CSet:TSysCharset);

function TrimLeftSet(const S: String;const CSet:TSysCharSet): String;
Function TrimRightSet(const S: String;const CSet:TSysCharSet): String;
function TrimSet(const S: String;const CSet:TSysCharSet): String;


type
  SizeIntArray = array of SizeInt;

procedure FindMatchesBoyerMooreCaseSensitive(const S,OldPattern: PChar; const SSize, OldPatternSize: SizeInt; out aMatches: SizeIntArray; const aMatchAll: Boolean); 
procedure FindMatchesBoyerMooreCaseSensitive(const S,OldPattern: String; out aMatches: SizeIntArray; const aMatchAll: Boolean); 

procedure FindMatchesBoyerMooreCaseInSensitive(const S, OldPattern: PChar; const SSize, OldPatternSize: SizeInt; out aMatches: SizeIntArray; const aMatchAll: Boolean); 
procedure FindMatchesBoyerMooreCaseInSensitive(const S, OldPattern: String; out aMatches: SizeIntArray; const aMatchAll: Boolean);

Type
  TStringReplaceAlgorithm = (sraDefault,    // Default algoritm as used in StringUtils.
                             sraManySmall,       // Algorithm optimized for many small replacements.
                             sraBoyerMoore  // Algorithm optimized for long replacements.
                            );

Function StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags; Algorithm : TStringReplaceAlgorithm = sraDefault): string; overload;
{ We need these for backwards compatibility:
  The compiler will stop searching and convert to ansistring if the widestring version of stringreplace is used.
  They currently simply refer to sysutils, till the new mechanisms are proven to work with unicode.}
Function StringReplace(const S, OldPattern, NewPattern: unicodestring; Flags: TReplaceFlags): unicodestring; overload;
Function StringReplace(const S, OldPattern, NewPattern: widestring; Flags: TReplaceFlags): widestring; overload;

implementation

(*
  FindMatchesBoyerMooreCaseSensitive

  Finds one or many ocurrences of an ansistring in another ansistring.
  It is case sensitive.

  * Parameters:
  S: The PChar to be searched in. (Read only).
  OldPattern: The PChar to be searched. (Read only).
  SSize: The size of S in Chars. (Read only).
  OldPatternSize: The size of OldPatter in chars. (Read only).
  aMatches: SizeInt array where match indexes are returned (zero based) (write only).
  aMatchAll: Finds all matches, not just the first one. (Read only).

  * Returns:
    Nothing, information returned in aMatches parameter.

  The function is based in the Boyer-Moore algorithm.
*)

procedure FindMatchesBoyerMooreCaseSensitive(const S, OldPattern: PChar;
  const SSize, OldPatternSize: SizeInt; out aMatches: SizeIntArray;
  const aMatchAll: Boolean);
const
  ALPHABET_LENGHT=256;
  MATCHESCOUNTRESIZER=100; //Arbitrary value. Memory used = MATCHESCOUNTRESIZER * sizeof(SizeInt)
var
  //Stores the amount of replaces that will take place
  MatchesCount: SizeInt;
  //Currently allocated space for matches.
  MatchesAllocatedLimit: SizeInt;
type
  AlphabetArray=array [0..ALPHABET_LENGHT-1] of SizeInt;

  function Max(const a1,a2: SizeInt): SizeInt;
  begin
    if a1>a2 then Result:=a1 else Result:=a2;
  end;

  procedure MakeDeltaJumpTable1(out DeltaJumpTable1: AlphabetArray; const aPattern: PChar; const aPatternSize: SizeInt);
  var
    i: SizeInt;
  begin
    for i := 0 to ALPHABET_LENGHT-1 do begin
      DeltaJumpTable1[i]:=aPatternSize;
    end;
    //Last char do not enter in the equation
    for i := 0 to aPatternSize - 1 - 1 do begin
      DeltaJumpTable1[Ord(aPattern[i])]:=aPatternSize -1 - i;
    end;
  end;

  function IsPrefix(const aPattern: PChar; const aPatternSize, aPos: SizeInt): Boolean;
  var
    i: SizeInt;
    SuffixLength: SizeInt;
  begin
    SuffixLength:=aPatternSize-aPos;
    for i := 0 to SuffixLength-1 do begin
      if (aPattern[i] <> aPattern[aPos+i]) then begin
          exit(false);
      end;
    end;
    Result:=true;
  end;

  function SuffixLength(const aPattern: PChar; const aPatternSize, aPos: SizeInt): SizeInt;
  var
    i: SizeInt;
  begin
    i:=0;
    while (aPattern[aPos-i] = aPattern[aPatternSize-1-i]) and (i < aPos) do begin
      inc(i);
    end;
    Result:=i;
  end;

  procedure MakeDeltaJumpTable2(var DeltaJumpTable2: SizeIntArray; const aPattern: PChar; const aPatternSize: SizeInt);
  var
    Position: SizeInt;
    LastPrefixIndex: SizeInt;
    SuffixLengthValue: SizeInt;
  begin
    LastPrefixIndex:=aPatternSize-1;
    Position:=aPatternSize-1;
    while Position>=0 do begin
      if IsPrefix(aPattern,aPatternSize,Position+1) then begin
        LastPrefixIndex := Position+1;
      end;
      DeltaJumpTable2[Position] := LastPrefixIndex + (aPatternSize-1 - Position);
      Dec(Position);
    end;
    Position:=0;
    while Position<aPatternSize-1 do begin
      SuffixLengthValue:=SuffixLength(aPattern,aPatternSize,Position);
      if aPattern[Position-SuffixLengthValue] <> aPattern[aPatternSize-1 - SuffixLengthValue] then begin
        DeltaJumpTable2[aPatternSize - 1 - SuffixLengthValue] := aPatternSize - 1 - Position + SuffixLengthValue;
      end;
      Inc(Position);
    end;
  end;

  //Resizes the allocated space for replacement index
  procedure ResizeAllocatedMatches;
  begin
    MatchesAllocatedLimit:=MatchesCount+MATCHESCOUNTRESIZER;
    SetLength(aMatches,MatchesAllocatedLimit);
  end;

  //Add a match to be replaced
  procedure AddMatch(const aPosition: SizeInt); inline;
  begin
    if MatchesCount = MatchesAllocatedLimit then begin
      ResizeAllocatedMatches;
    end;
    aMatches[MatchesCount]:=aPosition;
    inc(MatchesCount);
  end;
var
  i,j: SizeInt;
  DeltaJumpTable1: array [0..ALPHABET_LENGHT-1] of SizeInt;
  DeltaJumpTable2: SizeIntArray;
begin
  MatchesCount:=0;
  MatchesAllocatedLimit:=0;
  SetLength(aMatches,MatchesCount);
  if OldPatternSize=0 then begin
    Exit;
  end;
  SetLength(DeltaJumpTable2,OldPatternSize);

  MakeDeltaJumpTable1(DeltaJumpTable1,OldPattern,OldPatternSize);
  MakeDeltaJumpTable2(DeltaJumpTable2,OldPattern,OldPatternSize);

  i:=OldPatternSize-1;
  while i < SSize do begin
    j:=OldPatternSize-1;
    while (j>=0) and (S[i] = OldPattern[j]) do begin
      dec(i);
      dec(j);
    end;
    if (j<0) then begin
      AddMatch(i+1);
      //Only first match ?
      if not aMatchAll then break;
      inc(i,OldPatternSize);
      inc(i,OldPatternSize);
    end else begin
      i:=i + Max(DeltaJumpTable1[ord(s[i])],DeltaJumpTable2[j]);
    end;
  end;
  SetLength(aMatches,MatchesCount);
end;

procedure FindMatchesBoyerMooreCaseINSensitive(const S, OldPattern: PChar;
  const SSize, OldPatternSize: SizeInt; out aMatches: SizeIntArray;
  const aMatchAll: Boolean);
const
  ALPHABET_LENGHT=256;
  MATCHESCOUNTRESIZER=100; //Arbitrary value. Memory used = MATCHESCOUNTRESIZER * sizeof(SizeInt)
var
  //Lowercased OldPattern
  lPattern: string;
  //Array of lowercased alphabet
  lCaseArray: array [0..ALPHABET_LENGHT-1] of char;
  //Stores the amount of replaces that will take place
  MatchesCount: SizeInt;
  //Currently allocated space for matches.
  MatchesAllocatedLimit: SizeInt;
type
  AlphabetArray=array [0..ALPHABET_LENGHT-1] of SizeInt;

  function Max(const a1,a2: SizeInt): SizeInt;
  begin
    if a1>a2 then Result:=a1 else Result:=a2;
  end;

  procedure MakeDeltaJumpTable1(out DeltaJumpTable1: AlphabetArray; const aPattern: PChar; const aPatternSize: SizeInt);
  var
    i: SizeInt;
  begin
    for i := 0 to ALPHABET_LENGHT-1 do begin
      DeltaJumpTable1[i]:=aPatternSize;
    end;
    //Last char do not enter in the equation
    for i := 0 to aPatternSize - 1 - 1 do begin
      DeltaJumpTable1[Ord(aPattern[i])]:=aPatternSize - 1 - i;
    end;
  end;

  function IsPrefix(const aPattern: PChar; const aPatternSize, aPos: SizeInt): Boolean; inline;
  var
    i: SizeInt;
    SuffixLength: SizeInt;
  begin
    SuffixLength:=aPatternSize-aPos;
    for i := 0 to SuffixLength-1 do begin
      if (aPattern[i+1] <> aPattern[aPos+i]) then begin
        exit(false);
      end;
    end;
    Result:=true;
  end;

  function SuffixLength(const aPattern: PChar; const aPatternSize, aPos: SizeInt): SizeInt; inline;
  var
    i: SizeInt;
  begin
    i:=0;
    while (aPattern[aPos-i] = aPattern[aPatternSize-1-i]) and (i < aPos) do begin
      inc(i);
    end;
    Result:=i;
  end;

  procedure MakeDeltaJumpTable2(var DeltaJumpTable2: SizeIntArray; const aPattern: PChar; const aPatternSize: SizeInt);
  var
    Position: SizeInt;
    LastPrefixIndex: SizeInt;
    SuffixLengthValue: SizeInt;
  begin
    LastPrefixIndex:=aPatternSize-1;
    Position:=aPatternSize-1;
    while Position>=0 do begin
      if IsPrefix(aPattern,aPatternSize,Position+1) then begin
        LastPrefixIndex := Position+1;
      end;
      DeltaJumpTable2[Position] := LastPrefixIndex + (aPatternSize-1 - Position);
      Dec(Position);
    end;
    Position:=0;
    while Position<aPatternSize-1 do begin
      SuffixLengthValue:=SuffixLength(aPattern,aPatternSize,Position);
      if aPattern[Position-SuffixLengthValue] <> aPattern[aPatternSize-1 - SuffixLengthValue] then begin
        DeltaJumpTable2[aPatternSize - 1 - SuffixLengthValue] := aPatternSize - 1 - Position + SuffixLengthValue;
      end;
      Inc(Position);
    end;
  end;

  //Resizes the allocated space for replacement index
  procedure ResizeAllocatedMatches;
  begin
    MatchesAllocatedLimit:=MatchesCount+MATCHESCOUNTRESIZER;
    SetLength(aMatches,MatchesAllocatedLimit);
  end;

  //Add a match to be replaced
  procedure AddMatch(const aPosition: SizeInt); inline;
  begin
    if MatchesCount = MatchesAllocatedLimit then begin
      ResizeAllocatedMatches;
    end;
    aMatches[MatchesCount]:=aPosition;
    inc(MatchesCount);
  end;
var
  i,j: SizeInt;
  DeltaJumpTable1: array [0..ALPHABET_LENGHT-1] of SizeInt;
  DeltaJumpTable2: SizeIntArray;
  //Pointer to lowered OldPattern
  plPattern: PChar;
begin
  MatchesCount:=0;
  MatchesAllocatedLimit:=0;
  SetLength(aMatches,MatchesCount);
  if OldPatternSize=0 then begin
    Exit;
  end;

  //Build an internal array of lowercase version of every possible char.
  for j := 0 to Pred(ALPHABET_LENGHT) do begin
    lCaseArray[j]:=AnsiLowerCase(char(j))[1];
  end;

  //Create the new lowercased pattern
  SetLength(lPattern,OldPatternSize);
  for j := 0 to Pred(OldPatternSize) do begin
    lPattern[j+1]:=lCaseArray[ord(OldPattern[j])];
  end;

  SetLength(DeltaJumpTable2,OldPatternSize);

  MakeDeltaJumpTable1(DeltaJumpTable1,@lPattern[1],OldPatternSize);
  MakeDeltaJumpTable2(DeltaJumpTable2,@lPattern[1],OldPatternSize);

  plPattern:=@lPattern[1];
  i:=OldPatternSize-1;
  while i < SSize do begin
    j:=OldPatternSize-1;
    while (j>=0) and (lCaseArray[Ord(S[i])] = plPattern[j]) do begin
      dec(i);
      dec(j);
    end;
    if (j<0) then begin
      AddMatch(i+1);
      //Only first match ?
      if not aMatchAll then break;
      inc(i,OldPatternSize);
      inc(i,OldPatternSize);
    end else begin
      i:=i + Max(DeltaJumpTable1[Ord(lCaseArray[Ord(s[i])])],DeltaJumpTable2[j]);
    end;
  end;
  SetLength(aMatches,MatchesCount);
end;

function StringReplaceFast(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
const
  MATCHESCOUNTRESIZER=100; //Arbitrary value. Memory used = MATCHESCOUNTRESIZER * sizeof(SizeInt)
var
  //Stores where a replace will take place
  Matches: array of SizeInt;
  //Stores the amount of replaces that will take place
  MatchesCount: SizeInt;
  //Currently allocated space for matches.
  MatchesAllocatedLimit: SizeInt;
  //Uppercase version of pattern
  PatternUppercase: string;
  //Lowercase version of pattern
  PatternLowerCase: string;
  //Index
  MatchIndex: SizeInt;
  MatchLimit: SizeInt;
  MatchInternal: SizeInt;
  MatchTarget: SizeInt;
  AdvanceIndex: SizeInt;

  //Miscelanous variables
  OldPatternSize: SizeInt;
  NewPatternSize: SizeInt;

  //Resizes the allocated space for replacement index
  procedure ResizeAllocatedMatches;
  begin
    MatchesAllocatedLimit:=MatchesCount+MATCHESCOUNTRESIZER;
    SetLength(Matches,MatchesAllocatedLimit);
  end;

  //Add a match to be replaced
  procedure AddMatch(const aPosition: SizeInt); inline;
  begin
    if MatchesCount = MatchesAllocatedLimit then begin
      ResizeAllocatedMatches;
    end;
    Matches[MatchesCount]:=aPosition;
    inc(MatchesCount);
  end;
begin
  if (OldPattern='') or (Length(OldPattern)>Length(S)) then begin
    //This cases will never match nothing.
    Result:=S;
    exit;
  end;
  Result:='';
  OldPatternSize:=Length(OldPattern);
  MatchesCount:=0;
  MatchesAllocatedLimit:=0;
  if rfIgnoreCase in Flags then begin
    //Different algorithm for case sensitive and insensitive
    //This is insensitive, so 2 new ansistrings are created for search pattern, one upper and one lower case.
    //It is easy, usually, to create 2 versions of the match pattern than uppercased and lowered case each
    //character in the "to be matched" string.
    PatternUppercase:=AnsiUpperCase(OldPattern);
    PatternLowerCase:=AnsiLowerCase(OldPattern);
    MatchIndex:=Length(OldPattern);
    MatchLimit:=Length(S);
    NewPatternSize:=Length(NewPattern);
    while MatchIndex <= MatchLimit do begin
      if (S[MatchIndex]=PatternLowerCase[OldPatternSize]) or (S[MatchIndex]=PatternUppercase[OldPatternSize]) then begin
        //Match backwards...
        MatchInternal:=OldPatternSize-1;
        MatchTarget:=MatchIndex-1;
        while MatchInternal>=1 do begin
          if (S[MatchTarget]=PatternLowerCase[MatchInternal]) or (S[MatchTarget]=PatternUppercase[MatchInternal]) then begin
            dec(MatchInternal);
            dec(MatchTarget);
          end else begin
            break;
          end;
        end;
        if MatchInternal=0 then begin
          //Match found, all char meet the sequence
          //MatchTarget points to char before, so matching is +1
          AddMatch(MatchTarget+1);
          inc(MatchIndex,OldPatternSize);
          if not (rfReplaceAll in Flags) then begin
            break;
          end;
        end else begin
          //Match not found
          inc(MatchIndex);
        end;
      end else begin
        inc(MatchIndex);
      end;
    end;
  end else begin
    //Different algorithm for case sensitive and insensitive
    //This is sensitive, so just 1 binary comprare
    MatchIndex:=Length(OldPattern);
    MatchLimit:=Length(S);
    NewPatternSize:=Length(NewPattern);
    while MatchIndex <= MatchLimit do begin
      if (S[MatchIndex]=OldPattern[OldPatternSize]) then begin
        //Match backwards...
        MatchInternal:=OldPatternSize-1;
        MatchTarget:=MatchIndex-1;
        while MatchInternal>=1 do begin
          if (S[MatchTarget]=OldPattern[MatchInternal]) then begin
            dec(MatchInternal);
            dec(MatchTarget);
          end else begin
            break;
          end;
        end;
        if MatchInternal=0 then begin
          //Match found, all char meet the sequence
          //MatchTarget points to char before, so matching is +1
          AddMatch(MatchTarget+1);
          inc(MatchIndex,OldPatternSize);
          if not (rfReplaceAll in Flags) then begin
            break;
          end;
        end else begin
          //Match not found
          inc(MatchIndex);
        end;
      end else begin
        inc(MatchIndex);
      end;
    end;
  end;
  //Create room enougth for the result string
  SetLength(Result,Length(S)-OldPatternSize*MatchesCount+NewPatternSize*MatchesCount);
  MatchIndex:=1;
  MatchTarget:=1;
  //Matches[x] are 1 based offsets
  for MatchInternal := 0 to Pred(MatchesCount) do begin
    //Copy information up to next match
    AdvanceIndex:=Matches[MatchInternal]-MatchIndex;
    if AdvanceIndex>0 then begin
      move(S[MatchIndex],Result[MatchTarget],AdvanceIndex);
      inc(MatchTarget,AdvanceIndex);
      inc(MatchIndex,AdvanceIndex);
    end;
    //Copy the new replace information string
    if NewPatternSize>0 then begin
      move(NewPattern[1],Result[MatchTarget],NewPatternSize);
      inc(MatchTarget,NewPatternSize);
    end;
    inc(MatchIndex,OldPatternSize);
  end;
  if MatchTarget<=Length(Result) then begin
    //Add remain data at the end of source.
    move(S[MatchIndex],Result[MatchTarget],Length(Result)-MatchTarget+1);
  end;
end;

(*
  StringReplaceBoyerMoore

  Replaces one or many ocurrences of an ansistring in another ansistring by a new one.
  It can perform the compare ignoring case (ansi).

  * Parameters (Read only):
  S: The string to be searched in.
  OldPattern: The string to be searched.
  NewPattern: The string to replace OldPattern matches.
  Flags:
    rfReplaceAll: Replace all occurrences.
    rfIgnoreCase: Ignore case in OldPattern matching.

  * Returns:
    The modified string (if needed).

  It is memory conservative, just sizeof(SizeInt) per match in blocks off 100 matches
  plus Length(OldPattern)*2 in the case of ignoring case.
  Memory copies are the minimun necessary.
  Algorithm based in the Boyer-Moore string search algorithm.

  It is faster when the "S" string is very long and the OldPattern is also
  very big. As much big the OldPattern is, faster the search is too.

  It uses 2 different helper versions of Boyer-Moore algorithm, one for case
  sensitive and one for case INsensitive for speed reasons.

*)

function StringReplaceBoyerMoore(const S, OldPattern, NewPattern: string;Flags: TReplaceFlags): string;
var
  Matches: SizeIntArray;
  OldPatternSize: SizeInt;
  NewPatternSize: SizeInt;
  MatchesCount: SizeInt;
  MatchIndex: SizeInt;
  MatchTarget: SizeInt;
  MatchInternal: SizeInt;
  AdvanceIndex: SizeInt;
begin
  OldPatternSize:=Length(OldPattern);
  NewPatternSize:=Length(NewPattern);
  if (OldPattern='') or (Length(OldPattern)>Length(S)) then begin
    Result:=S;
    exit;
  end;

  if rfIgnoreCase in Flags then begin
    FindMatchesBoyerMooreCaseINSensitive(@s[1],@OldPattern[1],Length(S),Length(OldPattern),Matches, rfReplaceAll in Flags);
  end else begin
    FindMatchesBoyerMooreCaseSensitive(@s[1],@OldPattern[1],Length(S),Length(OldPattern),Matches, rfReplaceAll in Flags);
  end;

  MatchesCount:=Length(Matches);

  //Create room enougth for the result string
  SetLength(Result,Length(S)-OldPatternSize*MatchesCount+NewPatternSize*MatchesCount);
  MatchIndex:=1;
  MatchTarget:=1;
  //Matches[x] are 0 based offsets
  for MatchInternal := 0 to Pred(MatchesCount) do begin
    //Copy information up to next match
    AdvanceIndex:=Matches[MatchInternal]+1-MatchIndex;
    if AdvanceIndex>0 then begin
      move(S[MatchIndex],Result[MatchTarget],AdvanceIndex);
      inc(MatchTarget,AdvanceIndex);
      inc(MatchIndex,AdvanceIndex);
    end;
    //Copy the new replace information string
    if NewPatternSize>0 then begin
      move(NewPattern[1],Result[MatchTarget],NewPatternSize);
      inc(MatchTarget,NewPatternSize);
    end;
    inc(MatchIndex,OldPatternSize);
  end;
  if MatchTarget<=Length(Result) then begin
    //Add remain data at the end of source.
    move(S[MatchIndex],Result[MatchTarget],Length(Result)-MatchTarget+1);
  end;
end;

Function StringReplace(const S, OldPattern, NewPattern: string; Flags: TReplaceFlags; Algorithm : TStringReplaceAlgorithm = sraDefault): string;

begin
  Case Algorithm of
    sraDefault    : Result:=sysutils.StringReplace(S,OldPattern,NewPattern,Flags);
    sraManySmall  : Result:=StringReplaceFast(S,OldPattern,NewPattern,Flags);
    sraBoyerMoore : Result:=StringReplaceBoyerMoore(S,OldPattern,NewPattern,Flags);
  end;
end;


Function StringReplace(const S, OldPattern, NewPattern: unicodestring; Flags: TReplaceFlags): unicodestring; overload;

begin
  Result:=sysutils.StringReplace(S,OldPattern,NewPattern,Flags);
end;

Function StringReplace(const S, OldPattern, NewPattern: widestring; Flags: TReplaceFlags): widestring; overload;

begin
  Result:=sysutils.StringReplace(S,OldPattern,NewPattern,Flags);
end;


procedure FindMatchesBoyerMooreCaseSensitive(const S,OldPattern: String; out aMatches: SizeIntArray; const aMatchAll: Boolean); 

Var
  I : SizeInt;

begin
  FindMatchesBoyerMooreCaseSensitive(PChar(S),Pchar(OldPattern),Length(S),Length(OldPattern),aMatches,aMatchAll);
  For I:=0 to pred(Length(AMatches)) do
    Inc(AMatches[i]);
end;

procedure FindMatchesBoyerMooreCaseInSensitive(const S, OldPattern: String; out aMatches: SizeIntArray; const aMatchAll: Boolean);

Var
  I : SizeInt;

begin
  FindMatchesBoyerMooreCaseInSensitive(PChar(S),Pchar(OldPattern),Length(S),Length(OldPattern),aMatches,aMatchAll);
  For I:=0 to pred(Length(AMatches)) do
    Inc(AMatches[i]);
end;


{ ---------------------------------------------------------------------
   Possibly Exception raising functions
  ---------------------------------------------------------------------}


function Hex2Dec(const S: string): Longint;
var
  HexStr: string;
begin
  if Pos('$',S)=0 then
    HexStr:='$'+ S
  else
    HexStr:=S;
  Result:=StrToInt(HexStr);
end;

{
  We turn off implicit exceptions, since these routines are tested, and it 
  saves 20% codesize (and some speed) and don't throw exceptions, except maybe 
  heap related. If they don't, that is consider a bug.

  In the future, be wary with routines that use strtoint, floating point 
  and/or format() derivatives. And check every divisor for 0.
}

{$IMPLICITEXCEPTIONS OFF}

{ ---------------------------------------------------------------------
    Case insensitive search/replace
  ---------------------------------------------------------------------}
Function AnsiResemblesText(const AText, AOther: string): Boolean;

begin
  if Assigned(AnsiResemblesProc) then
    Result:=AnsiResemblesProc(AText,AOther)
  else
    Result:=False;
end;

Function AnsiContainsText(const AText, ASubText: string): Boolean;
begin
  AnsiContainsText:=AnsiPos(AnsiUppercase(ASubText),AnsiUppercase(AText))>0;
end;


Function AnsiStartsText(const ASubText, AText: string): Boolean;
begin
  if (Length(AText) >= Length(ASubText)) and (ASubText <> '') then
    Result := AnsiStrLIComp(PChar(ASubText), PChar(AText), Length(ASubText)) = 0
  else
    Result := False;
end;


Function AnsiEndsText(const ASubText, AText: string): Boolean;
begin
  if Length(AText) >= Length(ASubText) then
    Result := AnsiStrLIComp(PChar(ASubText),
      PChar(AText) + Length(AText) - Length(ASubText), Length(ASubText)) = 0
  else
    Result := False;
end;


Function AnsiReplaceText(const AText, AFromText, AToText: string): string;inline;
begin
  Result := StringReplace(AText,AFromText,AToText,[rfReplaceAll,rfIgnoreCase]);
end;


Function AnsiMatchText(const AText: string; const AValues: array of string): Boolean;
begin
  Result:=(AnsiIndexText(AText,AValues)<>-1)
end;


Function AnsiIndexText(const AText: string; const AValues: array of string): Integer;

var
  i : Integer;

begin
  Result:=-1;
  if (high(AValues)=-1) or (High(AValues)>MaxInt) Then
    Exit;
  for i:=low(AValues) to High(Avalues) do
     if CompareText(avalues[i],atext)=0 Then
       exit(i);  // make sure it is the first val.
end;


{ ---------------------------------------------------------------------
    Case sensitive search/replace
  ---------------------------------------------------------------------}

Function AnsiContainsStr(const AText, ASubText: string): Boolean;inline;
begin
  Result := AnsiPos(ASubText,AText)>0;
end;


Function AnsiStartsStr(const ASubText, AText: string): Boolean;
begin
  if (Length(AText) >= Length(ASubText)) and (ASubText <> '') then
    Result := AnsiStrLComp(PChar(ASubText), PChar(AText), Length(ASubText)) = 0
  else
    Result := False;
end;


Function AnsiEndsStr(const ASubText, AText: string): Boolean;
begin
  if Length(AText) >= Length(ASubText) then
    Result := AnsiStrLComp(PChar(ASubText),
      PChar(AText) + Length(AText) - Length(ASubText), Length(ASubText)) = 0
  else
    Result := False;
end;


Function AnsiReplaceStr(const AText, AFromText, AToText: string): string;inline;
begin
Result := StringReplace(AText,AFromText,AToText,[rfReplaceAll]);
end;


Function AnsiMatchStr(const AText: string; const AValues: array of string): Boolean;
begin
  Result:=AnsiIndexStr(AText,Avalues)<>-1;
end;


Function AnsiIndexStr(const AText: string; const AValues: array of string): Integer;
var
  i : longint;
begin
  result:=-1;
  if (high(AValues)=-1) or (High(AValues)>MaxInt) Then
    Exit;
  for i:=low(AValues) to High(Avalues) do
     if (avalues[i]=AText) Then
       exit(i);                                 // make sure it is the first val.
end;


Function MatchStr(const AText: UnicodeString; const AValues: array of UnicodeString): Boolean;
begin
  Result := IndexStr(AText,AValues) <> -1;
end;


Function IndexStr(const AText: UnicodeString; const AValues: array of UnicodeString): Integer;
var
  i: longint;
begin
  Result := -1;
  if (high(AValues) = -1) or (High(AValues) > MaxInt) Then
    Exit;
  for i := low(AValues) to High(Avalues) do
     if (avalues[i] = AText) Then
       exit(i);                                 // make sure it is the first val.
end;

{ ---------------------------------------------------------------------
    Playthingies
  ---------------------------------------------------------------------}

Function DupeString(const AText: string; ACount: Integer): string;

var i,l : SizeInt;

begin
 result:='';
 if aCount>=0 then
   begin
     l:=length(atext);
     SetLength(result,aCount*l);
     for i:=0 to ACount-1 do
       move(atext[1],Result[l*i+1],l);
   end;
end;

Function ReverseString(const AText: string): string;

var
  i,j : SizeInt;

begin
  setlength(result,length(atext));
  i:=1; j:=length(atext);
  while (i<=j) do
    begin
      result[i]:=atext[j-i+1];
      inc(i);
    end;
end;


Function AnsiReverseString(const AText: AnsiString): AnsiString;inline;

begin
  Result:=ReverseString(AText);
end;



Function StuffString(const AText: string; AStart, ALength: Cardinal;  const ASubText: string): string;

var i,j,k : SizeUInt;

begin
  j:=length(ASubText);
  i:=length(AText);
  if AStart>i then 
    aStart:=i+1;
  k:=i+1-AStart;
  if ALength> k then
    ALength:=k;
  SetLength(Result,i+j-ALength);
  move (AText[1],result[1],AStart-1);
  move (ASubText[1],result[AStart],j);
  move (AText[AStart+ALength], Result[AStart+j],i+1-AStart-ALength);
end;

Function RandomFrom(const AValues: array of string): string; overload;

begin
  if high(AValues)=-1 then exit('');
  result:=Avalues[random(High(AValues)+1)];
end;

Function IfThen(AValue: Boolean; const ATrue: string; const AFalse: string = ''): string; overload;

begin
  if avalue then
    result:=atrue
  else
    result:=afalse;
end;

function NaturalCompareText(const Str1, Str2: string; const ADecSeparator, AThousandSeparator: Char): Integer;
{
 NaturalCompareBase compares strings in a collated order and
 so numbers are sorted too. It sorts like this:

 01
 001
 0001

 and

 0
 00
 000
 000_A
 000_B

 in a intuitive order.
 }
var
  Num1, Num2: double;
  pStr1, pStr2: PChar;
  Len1, Len2: SizeInt;
  TextLen1, TextLen2: SizeInt;
  TextStr1: string = '';
  TextStr2: string = '';
  i: SizeInt;
  j: SizeInt;
  
  function Sign(const AValue: sizeint): integer;inline;

  begin
    If Avalue<0 then
      Result:=-1
    else If Avalue>0 then
      Result:=1
    else
      Result:=0;
  end;

  function IsNumber(ch: char): boolean;
  begin
    Result := ch in ['0'..'9'];
  end;

  function GetInteger(var pch: PChar; var Len: sizeint): double;
  begin
    Result := 0;
    while (pch^ <> #0) and IsNumber(pch^) do
    begin
      Result := Result * 10 + Ord(pch^) - Ord('0');
      Inc(Len);
      Inc(pch);
    end;
  end;

  procedure GetChars;
  begin
    TextLen1 := 0;
    while not ((pStr1 + TextLen1)^ in ['0'..'9']) and ((pStr1 + TextLen1)^ <> #0) do
      Inc(TextLen1);
    SetLength(TextStr1, TextLen1);
    i := 1;
    j := 0;
    while i <= TextLen1 do
    begin
      TextStr1[i] := (pStr1 + j)^;
      Inc(i);
      Inc(j);
    end;

    TextLen2 := 0;
    while not ((pStr2 + TextLen2)^ in ['0'..'9']) and ((pStr2 + TextLen2)^ <> #0) do
      Inc(TextLen2);
    SetLength(TextStr2, TextLen2);
    i := 1;
    j := 0;
    while i <= TextLen2 do
    begin
      TextStr2[i] := (pStr2 + j)^;
      Inc(i);
      Inc(j);
    end;
  end;

begin
  if (Str1 <> '') and (Str2 <> '') then
  begin
    pStr1 := PChar(Str1);
    pStr2 := PChar(Str2);
    Result := 0;
    while not ((pStr1^ = #0) or (pStr2^ = #0)) do
    begin
      TextLen1 := 1;
      TextLen2 := 1;
      Len1 := 0;
      Len2 := 0;
      while (pStr1^ = ' ') do
      begin
        Inc(pStr1);
        Inc(Len1);
      end;
      while (pStr2^ = ' ') do
      begin
        Inc(pStr2);
        Inc(Len2);
      end;
      if IsNumber(pStr1^) and IsNumber(pStr2^) then
      begin
         Num1 := GetInteger(pStr1, Len1);
         Num2 := GetInteger(pStr2, Len2);
        if Num1 < Num2 then
          Result := -1
        else if Num1 > Num2 then
          Result := 1
        else
        begin
          Result := Sign(Len1 - Len2);
        end;
        Dec(pStr1);
        Dec(pStr2);
      end
      else
      begin
        GetChars;
        if TextStr1 <> TextStr2 then
          Result := WideCompareText(UTF8Decode(TextStr1), UTF8Decode(TextStr2))
        else
          Result := 0;
      end;
      if Result <> 0 then
        Break;
      Inc(pStr1, TextLen1);
      Inc(pStr2, TextLen2);
    end;
  end;
  Num1 := Length(Str1);
  Num2 := Length(Str2);
  if (Result = 0) and (Num1 <> Num2) then
  begin
    if Num1 < Num2 then
      Result := -1
    else
      Result := 1;
  end;
end;

function NaturalCompareText (const S1 , S2 : string ): Integer ;
begin
  Result := NaturalCompareText(S1, S2,
                               DefaultFormatSettings.DecimalSeparator,
                               DefaultFormatSettings.ThousandSeparator);
end;

{ ---------------------------------------------------------------------
    VB emulations.
  ---------------------------------------------------------------------}

Function LeftStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;inline;

begin
  Result:=Copy(AText,1,ACount);
end;

Function RightStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;

var j,l:SizeInt;

begin
  l:=length(atext);
  j:=ACount;
  if j>l then j:=l;
  Result:=Copy(AText,l-j+1,j);
end;

Function MidStr(const AText: AnsiString; const AStart, ACount: SizeInt): AnsiString;inline;

begin
  if (ACount=0) or (AStart>length(atext)) then
    exit('');
  Result:=Copy(AText,AStart,ACount);
end;



Function LeftBStr(const AText: AnsiString; const AByteCount: SizeInt): AnsiString;inline;

begin
  Result:=LeftStr(AText,AByteCount);
end;


Function RightBStr(const AText: AnsiString; const AByteCount: SizeInt): AnsiString;inline;
begin
  Result:=RightStr(Atext,AByteCount);
end;


Function MidBStr(const AText: AnsiString; const AByteStart, AByteCount: SizeInt): AnsiString;inline;
begin
  Result:=MidStr(AText,AByteStart,AByteCount);
end;


Function AnsiLeftStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;inline;
begin
  Result := copy(AText,1,ACount);
end;


Function AnsiRightStr(const AText: AnsiString; const ACount: SizeInt): AnsiString;inline;
begin
  Result := copy(AText,length(AText)-ACount+1,ACount);
end;


Function AnsiMidStr(const AText: AnsiString; const AStart, ACount: SizeInt): AnsiString;inline;
begin
  Result:=Copy(AText,AStart,ACount);
end;


Function LeftStr(const AText: WideString; const ACount: SizeInt): WideString;inline;
begin
  Result:=Copy(AText,1,ACount);
end;


Function RightStr(const AText: WideString; const ACount: SizeInt): WideString;
var
  j,l:SizeInt;
begin
  l:=length(atext);
  j:=ACount;
  if j>l then j:=l;
  Result:=Copy(AText,l-j+1,j);
end;


Function MidStr(const AText: WideString; const AStart, ACount: SizeInt): WideString;inline;
begin
  Result:=Copy(AText,AStart,ACount);
end;


{ ---------------------------------------------------------------------
    Extended search and replace
  ---------------------------------------------------------------------}

type
  TEqualFunction = function (const a,b : char) : boolean;

function EqualWithCase (const a,b : char) : boolean;
begin
  result := (a = b);
end;

function EqualWithoutCase (const a,b : char) : boolean;
begin
  result := (lowerCase(a) = lowerCase(b));
end;

function IsWholeWord (bufstart, bufend, wordstart, wordend : pchar) : boolean;
begin
            // Check start
  result := ((wordstart = bufstart) or ((wordstart-1)^ in worddelimiters)) and
            // Check end
            ((wordend = bufend) or ((wordend+1)^ in worddelimiters));
end;

function SearchDown(buf,aStart,endchar:pchar; SearchString:string;
    Equals : TEqualFunction; WholeWords:boolean) : pchar;
var Found : boolean;
    s, c : pchar;
begin
  result := aStart;
  Found := false;
  while not Found and (result <= endchar) do
    begin
    // Search first letter
    while (result <= endchar) and not Equals(result^,SearchString[1]) do
      inc (result);
    // Check if following is searchstring
    c := result;
    s := @(Searchstring[1]);
    Found := true;
    while (c <= endchar) and (s^ <> #0) and Found do
      begin
      Found := Equals(c^, s^);
      inc (c);
      inc (s);
      end;
    if s^ <> #0 then
      Found := false;
    // Check if it is a word
    if Found and WholeWords then
      Found := IsWholeWord(buf,endchar,result,c-1);
    if not found then
      inc (result);
    end;
  if not Found then
    result := nil;
end;

function SearchUp(buf,aStart,endchar:pchar; SearchString:string;
    equals : TEqualFunction; WholeWords:boolean) : pchar;
var Found : boolean;
    s, c, l : pchar;
begin
  result := aStart;
  Found := false;
  l := @(SearchString[length(SearchString)]);
  while not Found and (result >= buf) do
    begin
    // Search last letter
    while (result >= buf) and not Equals(result^,l^) do
      dec (result);
    // Check if before is searchstring
    c := result;
    s := l;
    Found := true;
    while (c >= buf) and (s >= @SearchString[1]) and Found do
      begin
      Found := Equals(c^, s^);
      dec (c);
      dec (s);
      end;
    if (s >= @(SearchString[1])) then
      Found := false;
    // Check if it is a word
    if Found and WholeWords then
      Found := IsWholeWord(buf,endchar,c+1,result);
    if found then
      result := c+1
    else
      dec (result);
    end;
  if not Found then
    result := nil;
end;

//function SearchDown(buf,aStart,endchar:pchar; SearchString:string; equal : TEqualFunction; WholeWords:boolean) : pchar;
function SearchBuf(Buf: PChar;BufLen: SizeInt;SelStart: SizeInt;SelLength: SizeInt;
    SearchString: String;Options: TStringSearchOptions):PChar;
var
  equal : TEqualFunction;
begin
  SelStart := SelStart + SelLength;
  if (SearchString = '') or (SelStart > BufLen) or (SelStart < 0) then
    result := nil
  else
    begin
    if soMatchCase in Options then
      Equal := @EqualWithCase
    else
      Equal := @EqualWithoutCase;
    if soDown in Options then
      result := SearchDown(buf,buf+SelStart,Buf+(BufLen-1), SearchString, Equal, (soWholeWord in Options))
    else
      result := SearchUp(buf,buf+SelStart,Buf+(Buflen-1), SearchString, Equal, (soWholeWord in Options));
    end;
end;


Function SearchBuf(Buf: PChar; BufLen: SizeInt; SelStart, SelLength: SizeInt; SearchString: String): PChar;inline; // ; Options: TStringSearchOptions = [soDown]
begin
  Result:=SearchBuf(Buf,BufLen,SelStart,SelLength,SearchString,[soDown]);
end;

Function PosEx(const SubStr, S: string; Offset: SizeUint): SizeInt;

var
  i,MaxLen, SubLen : SizeInt;
  SubFirst: Char;
  pc : pchar;
begin
  PosEx:=0;
  SubLen := Length(SubStr);
  if (SubLen > 0) and (Offset > 0) and (Offset <= Cardinal(Length(S))) then
   begin
    MaxLen := Length(S)- SubLen;
    SubFirst := SubStr[1];
    i := indexbyte(S[Offset],Length(S) - Offset + 1, Byte(SubFirst));
    while (i >= 0) and ((i + sizeint(Offset) - 1) <= MaxLen) do
    begin
      pc := @S[i+SizeInt(Offset)];
      //we know now that pc^ = SubFirst, because indexbyte returned a value > -1
      if (CompareByte(Substr[1],pc^,SubLen) = 0) then
      begin
        PosEx := i + SizeInt(Offset);
        Exit;
      end;
      //point Offset to next char in S
      Offset := sizeuint(i) + Offset + 1;
      i := indexbyte(S[Offset],Length(S) - Offset + 1, Byte(SubFirst));
    end;
  end;
end;

Function PosEx(c:char; const S: string; Offset: SizeUint): SizeInt;

var
  p,Len : SizeInt;

begin
  Len := length(S);
  if (Offset < 1) or (Offset > SizeUInt(Length(S))) then exit(0);
  Len := length(S);
  p := indexbyte(S[Offset],Len-offset+1,Byte(c));
  if (p < 0) then
    PosEx := 0
  else
    PosEx := p + sizeint(Offset);
end; 

Function PosEx(const SubStr, S: string): SizeInt;inline; // Offset: Cardinal = 1
begin
  posex:=posex(substr,s,1);
end;

Function PosEx(const SubStr, S: UnicodeString; Offset: SizeUint): SizeInt;

var
  i,MaxLen, SubLen : SizeInt;
  SubFirst: WideChar;
  pc : pwidechar;
begin
  PosEx:=0;
  SubLen := Length(SubStr);
  if (SubLen > 0) and (Offset > 0) and (Offset <= Cardinal(Length(S))) then
   begin
    MaxLen := Length(S)- SubLen;
    SubFirst := SubStr[1];
    i := indexword(S[Offset],Length(S) - Offset + 1, Word(SubFirst));
    while (i >= 0) and ((i + sizeint(Offset) - 1) <= MaxLen) do
    begin
      pc := @S[i+SizeInt(Offset)];
      //we know now that pc^ = SubFirst, because indexbyte returned a value > -1
      if (CompareWord(Substr[1],pc^,SubLen) = 0) then
      begin
        PosEx := i + SizeInt(Offset);
        Exit;
      end;
      //point Offset to next char in S
      Offset := sizeuint(i) + Offset + 1;
      i := indexword(S[Offset],Length(S) - Offset + 1, Word(SubFirst));
    end;
  end;
end;

Function PosEx(c: WideChar; const S: UnicodeString; Offset: SizeUint): SizeInt;
var
  Len,p : SizeInt;

begin
  Len := length(S);
  if (Offset < 1) or (Offset > SizeUInt(Length(S))) then exit(0);
  Len := length(S);
  p := indexword(S[Offset],Len-offset+1,Word(c));
  if (p < 0) then
    PosEx := 0
  else
    PosEx := p + sizeint(Offset);
end;

Function PosEx(const SubStr, S: UnicodeString): SizeInt;inline; // Offset: Cardinal = 1
begin
  PosEx:=PosEx(SubStr,S,1);
end;


function StringsReplace(const S: string; OldPattern, NewPattern: array of string;  Flags: TReplaceFlags): string;

var pc,pcc,lastpc : pchar;
    strcount      : integer;
    ResStr,
    CompStr       : string;
    Found         : Boolean;
    sc            : sizeint;

begin
  sc := length(OldPattern);
  if sc <> length(NewPattern) then
    raise exception.Create(SErrAmountStrings);

  dec(sc);

  if rfIgnoreCase in Flags then
    begin
    CompStr:=AnsiUpperCase(S);
    for strcount := 0 to sc do
      OldPattern[strcount] := AnsiUpperCase(OldPattern[strcount]);
    end
  else
    CompStr := s;

  ResStr := '';
  pc := @CompStr[1];
  pcc := @s[1];
  lastpc := pc+Length(S);

  while pc < lastpc do
    begin
    Found := False;
    for strcount := 0 to sc do
      begin
      if (length(OldPattern[strcount])>0) and
         (OldPattern[strcount][1]=pc^) and
         (Length(OldPattern[strcount]) <= (lastpc-pc)) and
         (CompareByte(OldPattern[strcount][1],pc^,Length(OldPattern[strcount]))=0) then
        begin
        ResStr := ResStr + NewPattern[strcount];
        pc := pc+Length(OldPattern[strcount]);
        pcc := pcc+Length(OldPattern[strcount]);
        Found := true;
        end
      end;
    if not found then
      begin
      ResStr := ResStr + pcc^;
      inc(pc);
      inc(pcc);
      end
    else if not (rfReplaceAll in Flags) then
      begin
      ResStr := ResStr + StrPas(pcc);
      break;
      end;
    end;
  Result := ResStr;
end;

{ ---------------------------------------------------------------------
    Delphi compat
  ---------------------------------------------------------------------}

Function ReplaceStr(const AText, AFromText, AToText: string): string;inline;
begin
  result:=AnsiReplaceStr(AText, AFromText, AToText);
end;

Function ReplaceText(const AText, AFromText, AToText: string): string;inline;
begin
  result:=AnsiReplaceText(AText, AFromText, AToText);
end;

{ ---------------------------------------------------------------------
    Soundex Functions.
  ---------------------------------------------------------------------}
Const
  SScore : array[1..255] of Char =
     ('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0', // 1..32
      '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0', // 33..64
      '0','1','2','3','0','1','2','i','0','2','2','4','5','5','0','1','2','6','2','3','0','1','i','2','i','2', // 65..90
      '0','0','0','0','0','0', // 91..96
      '0','1','2','3','0','1','2','i','0','2','2','4','5','5','0','1','2','6','2','3','0','1','i','2','i','2', // 97..122
      '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0', // 123..154
      '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0', // 155..186
      '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0', // 187..218
      '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0', // 219..250
      '0','0','0','0','0'); // 251..255

Function Soundex(const AText: string; ALength: TSoundexLength): string;

Var
  S,PS : Char;
  I,L : SizeInt;

begin
  Result:='';
  PS:=#0;
  If Length(AText)>0 then
    begin
    Result:=Upcase(AText[1]);
    I:=2;
    L:=Length(AText);
    While (I<=L) and (Length(Result)<ALength) do
      begin
      S:=SScore[Ord(AText[i])];
      If Not (S in ['0','i',PS]) then
        Result:=Result+S;
      If (S<>'i') then
        PS:=S;
      Inc(I);
      end;
    end;
  L:=Length(Result);
  If (L<ALength) then
    Result:=Result+StringOfChar('0',Alength-L);
end;



Function Soundex(const AText: string): string;inline; // ; ALength: TSoundexLength = 4

begin
  Result:=Soundex(AText,4);
end;

Const
  Ord0 = Ord('0');
  OrdA = Ord('A');

Function SoundexInt(const AText: string; ALength: TSoundexIntLength): Integer;

var
  SE: string;
  I: SizeInt;

begin
  Result:=-1;
  SE:=Soundex(AText,ALength);
  If Length(SE)>0 then
    begin
    Result:=Ord(SE[1])-OrdA;
    if ALength > 1 then
      begin
      Result:=Result*26+(Ord(SE[2])-Ord0);
      for I:=3 to ALength do
        Result:=(Ord(SE[I])-Ord0)+Result*7;
      end;
    Result:=ALength+Result*9;
    end;
end;


Function SoundexInt(const AText: string): Integer;inline; //; ALength: TSoundexIntLength = 4
begin
  Result:=SoundexInt(AText,4);
end;


Function DecodeSoundexInt(AValue: Integer): string;

var
  I, Len: Integer;

begin
  Result := '';
  Len := AValue mod 9;
  AValue := AValue div 9;
  for I:=Len downto 3 do
    begin
    Result:=Chr(Ord0+(AValue mod 7))+Result;
    AValue:=AValue div 7;
    end;
  if Len>1 then
    begin
    Result:=Chr(Ord0+(AValue mod 26))+Result;
    AValue:=AValue div 26;
    end;
  Result:=Chr(OrdA+AValue)+Result;
end;


Function SoundexWord(const AText: string): Word;

Var
  S : String;

begin
  S:=SoundEx(Atext,4);
  Result:=Ord(S[1])-OrdA;
  Result:=Result*26+ord(S[2])-48;
  Result:=Result*7+ord(S[3])-48;
  Result:=Result*7+ord(S[4])-48;
end;


Function DecodeSoundexWord(AValue: Word): string;
begin
  Result := Chr(Ord0+ (AValue mod 7));
  AValue := AValue div 7;
  Result := Chr(Ord0+ (AValue mod 7)) + Result;
  AValue := AValue div 7;
  Result := IntToStr(AValue mod 26) + Result;
  AValue := AValue div 26;
  Result := Chr(OrdA+AValue) + Result;
end;


Function SoundexSimilar(const AText, AOther: string; ALength: TSoundexLength): Boolean;inline;
begin
  Result:=Soundex(AText,ALength)=Soundex(AOther,ALength);
end;


Function SoundexSimilar(const AText, AOther: string): Boolean;inline; //; ALength: TSoundexLength = 4
begin
  Result:=SoundexSimilar(AText,AOther,4);
end;


Function SoundexCompare(const AText, AOther: string; ALength: TSoundexLength): Integer;inline;
begin
  Result:=AnsiCompareStr(Soundex(AText,ALength),Soundex(AOther,ALength));
end;


Function SoundexCompare(const AText, AOther: string): Integer;inline; //; ALength: TSoundexLength = 4
begin
  Result:=SoundexCompare(AText,AOther,4);
end;


Function SoundexProc(const AText, AOther: string): Boolean;
begin
  Result:=SoundexSimilar(AText,AOther);
end;

{ ---------------------------------------------------------------------
    RxStrUtils-like functions.
  ---------------------------------------------------------------------}


function IsEmptyStr(const S: string; const EmptyChars: TSysCharSet): Boolean;

var
  i,l: SizeInt;

begin
  l:=Length(S);
  i:=1;
  Result:=True;
  while Result and (i<=l) do
    begin
    Result:=(S[i] in EmptyChars);
    Inc(i);
    end;
end;

function DelSpace(const S: String): string;

begin
  Result:=DelChars(S,' ');
end;

function DelChars(const S: string; Chr: Char): string;

var
  I,J: SizeInt;

begin
  Result:=S;
  I:=Length(Result);
  While I>0 do
    begin
    if Result[I]=Chr then
      begin
      J:=I-1;
      While (J>0) and (Result[J]=Chr) do
        Dec(j);
      Delete(Result,J+1,I-J);
      I:=J+1;
      end;
    dec(I);
    end;
end;

function DelSpace1(const S: string): string;

var
  I : SizeInt;

begin
  Result:=S;
  for i:=Length(Result) downto 2 do
    if (Result[i]=' ') and (Result[I-1]=' ') then
      Delete(Result,I,1);
end;

function Tab2Space(const S: string; Numb: Byte): string;

var
  I: SizeInt;

begin
  I:=1;
  Result:=S;
  while I <= Length(Result) do
    if Result[I]<>Chr(9) then
      inc(I)
    else
      begin
      Result[I]:=' ';
      If (Numb>1) then
        Insert(StringOfChar(' ',Numb-1),Result,I);
      Inc(I,Numb);
      end;
end;

function NPos(const C: string; S: string; N: Integer): SizeInt;

var
  i,p,k: SizeInt;

begin
  Result:=0;
  if N<1 then
    Exit;
  k:=0;
  i:=1;
  Repeat
    p:=pos(C,S);
    Inc(k,p);
    if p>0 then
      delete(S,1,p);
    Inc(i);
  Until (i>n) or (p=0);
  If (P>0) then
    Result:=K;
end;

function AddChar(C: Char; const S: string; N: Integer): string;

Var
  l : SizeInt;

begin
  Result:=S;
  l:=Length(Result);
  if l<N then
    Result:=StringOfChar(C,N-l)+Result;
end;

function AddCharR(C: Char; const S: string; N: Integer): string;

Var
  l : SizeInt;

begin
  Result:=S;
  l:=Length(Result);
  if l<N then
    Result:=Result+StringOfChar(C,N-l);
end;


function PadRight(const S: string; N: Integer): string;inline;
begin
  Result:=AddCharR(' ',S,N);
end;


function PadLeft(const S: string; N: Integer): string;inline;
begin
  Result:=AddChar(' ',S,N);
end;


function Copy2Symb(const S: string; Symb: Char): string;

var
  p: SizeInt;

begin
  p:=Pos(Symb,S);
  if p=0 then
    p:=Length(S)+1;
  Result:=Copy(S,1,p-1);
end;

function Copy2SymbDel(var S: string; Symb: Char): string;

var
  p: SizeInt;

begin
  p:=Pos(Symb,S);
  if p=0 then
    begin
      result:=s;
      s:='';
    end
  else
    begin	
      Result:=Copy(S,1,p-1);
      delete(s,1,p);		
    end;
end;

function Copy2Space(const S: string): string;inline;
begin
  Result:=Copy2Symb(S,' ');
end;

function Copy2SpaceDel(var S: string): string;inline;
begin
  Result:=Copy2SymbDel(S,' ');
end;

function AnsiProperCase(const S: string; const WordDelims: TSysCharSet): string;

var
  P,PE : PChar;

begin
  Result:=AnsiLowerCase(S);
  P:=PChar(pointer(Result));
  PE:=P+Length(Result);
  while (P<PE) do
    begin
    while (P<PE) and (P^ in WordDelims) do
      inc(P);
    if (P<PE) then
      P^:=UpCase(P^);
    while (P<PE) and not (P^ in WordDelims) do
      inc(P);
    end;
end;

function WordCount(const S: string; const WordDelims: TSysCharSet): SizeInt;

var
  P,PE : PChar;

begin
  Result:=0;
  P:=Pchar(pointer(S));
  PE:=P+Length(S);
  while (P<PE) do
    begin
    while (P<PE) and (P^ in WordDelims) do
      Inc(P);
    if (P<PE) then
      inc(Result);
    while (P<PE) and not (P^ in WordDelims) do
      inc(P);
    end;
end;

function WordPosition(const N: Integer; const S: string; const WordDelims: TSysCharSet): SizeInt;

var
  PS,P,PE : PChar;
  Count: Integer;

begin
  Result:=0;
  Count:=0;
  PS:=PChar(pointer(S));
  PE:=PS+Length(S);
  P:=PS;
  while (P<PE) and (Count<>N) do
    begin
    while (P<PE) and (P^ in WordDelims) do
      inc(P);
    if (P<PE) then
      inc(Count);
    if (Count<>N) then
      while (P<PE) and not (P^ in WordDelims) do
        inc(P)
    else
      Result:=(P-PS)+1;
    end;
end;


function ExtractWord(N: Integer; const S: string; const WordDelims: TSysCharSet): string;inline;
var
  i: SizeInt;
begin
  Result:=ExtractWordPos(N,S,WordDelims,i);
end;


function ExtractWordPos(N: Integer; const S: string; const WordDelims: TSysCharSet; out Pos: Integer): string;

var
  i,j,l: SizeInt;

begin
  j:=0;
  i:=WordPosition(N, S, WordDelims);
  if (I>High(Integer)) then
    begin
    Result:='';
    Pos:=-1;
    Exit;
    end;
  Pos:=i;
  if (i<>0) then
    begin
    j:=i;
    l:=Length(S);
    while (j<=L) and not (S[j] in WordDelims) do
      inc(j);
    end;
  SetLength(Result,j-i);
  If ((j-i)>0) then
    Move(S[i],Result[1],j-i);
end;

{$IF SIZEOF(SIZEINT)<>SIZEOF(INTEGER)}
function ExtractWordPos(N: Integer; const S: string; const WordDelims: TSysCharSet; Out Pos: SizeInt): string;
var
  i,j,l: SizeInt;

begin
  j:=0;
  i:=WordPosition(N, S, WordDelims);
  Pos:=i;
  if (i<>0) then
    begin
    j:=i;
    l:=Length(S);
    while (j<=L) and not (S[j] in WordDelims) do
      inc(j);
    end;
  SetLength(Result,j-i);
  If ((j-i)>0) then
    Move(S[i],Result[1],j-i);
end;
{$ENDIF}

function ExtractDelimited(N: Integer; const S: string; const Delims: TSysCharSet): string;
var
  w,i,l,len: SizeInt;
begin
  w:=0;
  i:=1;
  l:=0;
  len:=Length(S);
  SetLength(Result, 0);
  while (i<=len) and (w<>N) do
    begin
    if s[i] in Delims then
      inc(w)
    else
      begin
      if (N-1)=w then
        begin
        inc(l);
        SetLength(Result,l);
        Result[L]:=S[i];
        end;
      end;
    inc(i);
    end;
end;

{$IF SIZEOF(SIZEINT)<>SIZEOF(INTEGER)}
function ExtractSubstr(const S: string; var Pos: SizeInt; const Delims: TSysCharSet): string;

var
  i,l: SizeInt;

begin
  i:=Pos;
  l:=Length(S);
  while (i<=l) and not (S[i] in Delims) do
    inc(i);
  Result:=Copy(S,Pos,i-Pos);
  while (i<=l) and (S[i] in Delims) do
    inc(i);
  Pos:=i;
end;
{$ENDIF}

function ExtractSubstr(const S: string; var Pos: Integer; const Delims: TSysCharSet): string;

var
  i,l: SizeInt;

begin
  i:=Pos;
  l:=Length(S);
  while (i<=l) and not (S[i] in Delims) do
    inc(i);
  Result:=Copy(S,Pos,i-Pos);
  while (i<=l) and (S[i] in Delims) do
    inc(i);
  if I>MaxInt then
    Pos:=MaxInt
  else
    Pos:=i;
end;

function isWordPresent(const W, S: string; const WordDelims: TSysCharSet): Boolean;

var
  i,Count : SizeInt;

begin
  Result:=False;
  Count:=WordCount(S, WordDelims);
  I:=1;
  While (Not Result) and (I<=Count) do
    begin
    Result:=ExtractWord(i,S,WordDelims)=W;
    Inc(i);
    end;
end;


function Numb2USA(const S: string): string;
var
  i, NA: Integer;
begin
  i:=Length(S);
  Result:=S;
  NA:=0;
  while (i > 0) do begin
    if ((Length(Result) - i + 1 - NA) mod 3 = 0) and (i <> 1) then
    begin
      insert(',', Result, i);
      inc(NA);
    end;
    Dec(i);
  end;
end;

function PadCenter(const S: string; Len: SizeInt): string;
begin
  if Length(S)<Len then
    begin
    Result:=StringOfChar(' ',(Len div 2) -(Length(S) div 2))+S;
    Result:=Result+StringOfChar(' ',Len-Length(Result));
    end
  else
    Result:=S;
end;


function Dec2Numb(N: Longint; Len, Base: Byte): string;

var
  C: Integer;
  Number: Longint;

begin
  if N=0 then
    Result:='0'
  else
    begin
    Number:=N;
    Result:='';
    while Number>0 do
      begin
      C:=Number mod Base;
      if C>9 then
        C:=C+55
      else
        C:=C+48;
      Result:=Chr(C)+Result;
      Number:=Number div Base;
      end;
    end;
  if (Result<>'') then
    Result:=AddChar('0',Result,Len);
end;

function Numb2Dec(S: string; Base: Byte): Longint;

var
  i, P: sizeint;

begin
  i:=Length(S);
  Result:=0;
  S:=UpperCase(S);
  P:=1;
  while (i>=1) do
    begin
    if (S[i]>'@') then
      Result:=Result+(Ord(S[i])-55)*P
    else
      Result:=Result+(Ord(S[i])-48)*P;
    Dec(i);
    P:=P*Base;
    end;
end;


function RomanToIntDontCare(const S: String): Longint;
{This was the original implementation of RomanToInt,
 it is internally used in TryRomanToInt when Strictness = rcsDontCare}
const
  RomanChars  = ['C','D','I','L','M','V','X'];
  RomanValues : array['C'..'X'] of Word
              = (100,500,0,0,0,0,1,0,0,50,1000,0,0,0,0,0,0,0,0,5,0,10);

var
  index, Next: Char;
  i,l: SizeInt;
  Negative: Boolean;

begin
  Result:=0;
  i:=0;
  Negative:=(Length(S)>0) and (S[1]='-');
  if Negative then
    inc(i);
  l:=Length(S);
  while (i<l) do
    begin
    inc(i);
    index:=UpCase(S[i]);
    if index in RomanChars then
      begin
      if Succ(i)<=l then
        Next:=UpCase(S[i+1])
      else
        Next:=#0;
      if (Next in RomanChars) and (RomanValues[index]<RomanValues[Next]) then
        begin
        inc(Result, RomanValues[Next]);
        Dec(Result, RomanValues[index]);
        inc(i);
        end
      else
        inc(Result, RomanValues[index]);
      end
    else
      begin
      Result:=0;
      Exit;
      end;
    end;
  if Negative then
    Result:=-Result;
end;


{ TryRomanToInt: try to convert a roman numeral to an integer
  Parameters:
  S: Roman numeral (like: 'MCMXXII')
  N: Integer value of S (only meaningfull if the function succeeds)
  Stricness: controls how strict the parsing of S is
    - rcsStrict:
      * Follow common subtraction rules
         - only 1 preceding subtraction character allowed: IX = 9, but IIX <> 8
         - from M you can only subtract C
         - from D you can only subtract C
         - from C you can only subtract X
         - from L you can only subtract X
         - from X you can only subtract I
         - from V you can only subtract I
      *  The numeral is parsed in "groups" (first M's, then D's etc.), the next group to be parsed
         must always be of a lower denomination than the previous one.
         Example: 'MMDCCXX' is allowed but 'MMCCXXDD' is not
      * There can only ever be 3 consecutive M's, C's, X's or I's
      * There can only ever be 1 D, 1 L and 1 V
      * After IX or IV there can be no more characters
      * Negative numbers are not supported
      // As a consequence the maximum allowed Roman numeral is MMMCMXCIX = 3999, also N can never become 0 (zero)

    - rcsRelaxed: Like rcsStrict but with the following exceptions:
      * An infinite number of (leading) M's is allowed
      * Up to 4 consecutive M's, C's, X's and I's are allowed
      // So this is allowed: 'MMMMMMCXIIII'  = 6124

    - rcsDontCare:
      * no checking on the order of "groups" is done
      * there are no restrictions on the number of consecutive chars
      * negative numbers are supported
      * an empty string as input will return True and N will be 0
      * invalid input will return false
      // for backwards comatibility: it supports rather ludicrous input like '-IIIMIII' -> -(2+(1000-1)+3)=-1004
}

function TryRomanToInt(S: String; out N: LongInt; Strictness: TRomanConversionStrictness = rcsRelaxed): Boolean;

var
  i, Len: SizeInt;
  Terminated: Boolean;

begin
  Result := (False);
  S := UpperCase(S);  //don't use AnsiUpperCase please
  Len := Length(S);
  if (Strictness = rcsDontCare) then
  begin
    N := RomanToIntDontCare(S);
    if (N = 0) then
    begin
      Result := (Len = 0);
    end
    else
      Result := True;
    Exit;
  end;
  if (Len = 0) then Exit;
  i := 1;
  N := 0;
  Terminated := False;
  //leading M's
  while (i <= Len) and ((Strictness <> rcsStrict) or (i < 4)) and (S[i] = 'M') do
  begin
    //writeln('TryRomanToInt: Found 1000');
    Inc(i);
    N := N + 1000;
  end;
  //then CM or or CD or D or (C, CC, CCC, CCCC)
  if (i <= Len) and (S[i] = 'D') then
  begin
    //writeln('TryRomanToInt: Found 500');
    Inc(i);
    N := N + 500;
  end
  else if (i + 1 <= Len) and (S[i] = 'C') then
  begin
    if (S[i+1] = 'M') then
    begin
      //writeln('TryRomanToInt: Found 900');
      Inc(i,2);
      N := N + 900;
    end
    else if (S[i+1] = 'D') then
    begin
      //writeln('TryRomanToInt: Found 400');
      Inc(i,2);
      N := N + 400;
    end;
  end ;
  //next max 4 or 3 C's, depending on Strictness
  if (i <= Len) and (S[i] = 'C') then
  begin
    //find max 4 C's
    //writeln('TryRomanToInt: Found 100');
    Inc(i);
    N := N + 100;
    if (i <= Len) and (S[i] = 'C') then
    begin
      //writeln('TryRomanToInt: Found 100');
      Inc(i);
      N := N + 100;
    end;
    if (i <= Len) and (S[i] = 'C') then
    begin
      //writeln('TryRomanToInt: Found 100');
      Inc(i);
      N := N + 100;
    end;
    if (Strictness <> rcsStrict) and (i <= Len) and (S[i] = 'C') then
    begin
      //writeln('TryRomanToInt: Found 100');
      Inc(i);
      N := N + 100;
    end;
  end;

  //then XC or XL
  if (i + 1 <= Len) and (S[i] = 'X') then
  begin
    if (S[i+1] = 'C') then
    begin
      //writeln('TryRomanToInt: Found 90');
      Inc(i,2);
      N := N + 90;
    end
    else if  (S[i+1] = 'L') then
    begin
      //writeln('TryRomanToInt: Found 40');
      Inc(i,2);
      N := N + 40;
    end;
  end;

  //then L
  if (i <= Len) and (S[i] = 'L') then
  begin
    //writeln('TryRomanToInt: Found 50');
    Inc(i);
    N := N + 50;
  end;

  //then (X, xx, xxx, xxxx)
  if (i <= Len) and (S[i] = 'X') then
  begin
    //find max 3 or 4 X's, depending on Strictness
    //writeln('TryRomanToInt: Found 10');
    Inc(i);
    N := N + 10;
    if (i <= Len) and (S[i] = 'X') then
    begin
      //writeln('TryRomanToInt: Found 10');
      Inc(i);
      N := N + 10;
    end;
    if (i <= Len) and (S[i] = 'X') then
    begin
      //writeln('TryRomanToInt: Found 10');
      Inc(i);
      N := N + 10;
    end;
    if (Strictness <> rcsStrict) and (i <= Len) and (S[i] = 'X') then
    begin
      //writeln('TryRomanToInt: Found 10');
      Inc(i);
      N := N + 10;
    end;
  end;

  //then IX or IV
  if (i + 1 <= Len) and (S[i] = 'I') then
  begin
    if (S[i+1] = 'X') then
    begin
      Terminated := (True);
      //writeln('TryRomanToInt: Found 9');
      Inc(i,2);
      N := N + 9;
    end
    else if (S[i+1] = 'V') then
    begin
      Terminated := (True);
      //writeln('TryRomanToInt: Found 4');
      Inc(i,2);
      N := N + 4;
    end;
  end;

  //then V
  if (not Terminated) and (i <= Len) and (S[i] = 'V') then
  begin
    //writeln('TryRomanToInt: Found 5');
    Inc(i);
    N := N + 5;
  end;


  //then I
  if (not Terminated) and (i <= Len) and (S[i] = 'I') then
  begin
    Terminated := (True);
    //writeln('TryRomanToInt: Found 1');
    Inc(i);
    N := N + 1;
    //Find max 2 or 3 closing I's, depending on strictness
    if (i <= Len) and (S[i] = 'I') then
    begin
      //writeln('TryRomanToInt: Found 1');
      Inc(i);
      N := N + 1;
    end;
    if (i <= Len) and (S[i] = 'I') then
    begin
      //writeln('TryRomanToInt: Found 1');
      Inc(i);
      N := N + 1;
    end;
    if (Strictness <> rcsStrict) and (i <= Len) and (S[i] = 'I') then
    begin
      //writeln('TryRomanToInt: Found 1');
      Inc(i);
      N := N + 1;
    end;
  end;

  //writeln('TryRomanToInt: Len = ',Len,' i = ',i);
  Result := (i > Len);
  //if Result then writeln('TryRomanToInt: N = ',N);

end;

function RomanToInt(const S: string; Strictness: TRomanConversionStrictness = rcsRelaxed): Longint;
begin
  if not TryRomanToInt(S, Result, Strictness) then
    raise EConvertError.CreateFmt(SInvalidRomanNumeral,[S]);
end;

function RomanToIntDef(const S: String; const ADefault: Longint;
  Strictness: TRomanConversionStrictness): Longint;
begin
  if not TryRomanToInt(S, Result, Strictness) then
    Result := ADefault;
end;




function intToRoman(Value: Longint): string;

const
  Arabics : Array[1..13] of Integer
          = (1,4,5,9,10,40,50,90,100,400,500,900,1000);
  Romans  :  Array[1..13] of String
          = ('I','IV','V','IX','X','XL','L','XC','C','CD','D','CM','M');

var
  i: Integer;

begin
  Result:='';
  for i:=13 downto 1 do
    while (Value >= Arabics[i]) do
      begin
        Value:=Value-Arabics[i];
        Result:=Result+Romans[i];
      end;
end;

function intToBin(Value: Longint; Digits, Spaces: Integer): string;
var endpos : integer;
    p,p2:pchar;
    k: integer;
begin
  Result:='';
  if (Digits>32) then
    Digits:=32;
  if (spaces=0) then
   begin
     result:=inttobin(value,digits);
     exit;
   end;
  endpos:=digits+ (digits-1) div spaces;
  setlength(result,endpos);
  p:=@result[endpos];
  p2:=@result[1];
  k:=spaces;
  while (p>=p2) do
    begin
      if k=0 then
       begin
         p^:=' ';
         dec(p);
         k:=spaces;
       end;
      p^:=chr(48+(cardinal(value) and 1));
      value:=cardinal(value) shr 1;
      dec(p); 
      dec(k);
   end;
end;

function intToBin(Value: Longint; Digits:integer): string;
var p,p2 : pchar;
begin
  result:='';
  if digits<=0 then exit;
  setlength(result,digits);
  p:=pchar(pointer(@result[digits]));
  p2:=pchar(pointer(@result[1]));
  // typecasts because we want to keep intto* delphi compat and take an integer
  while (p>=p2) and (cardinal(value)>0) do     
    begin
       p^:=chr(48+(cardinal(value) and 1));
       value:=cardinal(value) shr 1;
       dec(p); 
    end;
  digits:=p-p2+1;
  if digits>0 then
    fillchar(result[1],digits,#48);
end;

function intToBin(Value: int64; Digits:integer): string;
var p,p2 : pchar;
begin
  result:='';
  if digits<=0 then exit;
  setlength(result,digits);
  p:=pchar(pointer(@result[digits]));
  p2:=pchar(pointer(@result[1]));
  // typecasts because we want to keep intto* delphi compat and take a signed val
  // and avoid warnings
  while (p>=p2) and (qword(value)>0) do     
    begin
       p^:=chr(48+(cardinal(value) and 1));
       value:=qword(value) shr 1;
       dec(p); 
    end;
  digits:=p-p2+1;
  if digits>0 then
    fillchar(result[1],digits,#48);
end;


function FindPart(const HelpWilds, inputStr: string): SizeInt;
var
  Diff, i, J: SizeInt;

begin
  Result:=0;
  i:=Pos('?',HelpWilds);
  if (i=0) then
    Result:=Pos(HelpWilds, inputStr)
  else
    begin
    Diff:=Length(inputStr) - Length(HelpWilds);
    for i:=0 to Diff do
      begin
      for J:=1 to Length(HelpWilds) do
        if (inputStr[i + J] = HelpWilds[J]) or (HelpWilds[J] = '?') then
          begin
          if (J=Length(HelpWilds)) then
            begin
            Result:=i+1;
            Exit;
            end;
          end
        else
          Break;
      end;
    end;
end;

Function isMatch(level : integer;inputstr,wilds : string; CWild, CinputWord: SizeInt;MaxInputword,maxwilds : SizeInt; Out EOS : Boolean) : Boolean;

begin
  EOS:=False;
  Result:=True;
  repeat
    if Wilds[CWild] = '*' then { handling of '*' }
      begin
      inc(CWild);
      while Wilds[CWild] = '?' do { equal to '?' }
        begin
        { goto next letter }
        inc(CWild);
        inc(CinputWord);
        end;
      { increase until a match }
      Repeat
        while (inputStr[CinputWord]<>Wilds[CWild]) and (CinputWord <= MaxinputWord) do
          inc(CinputWord);
        Result:=isMatch(Level+1,inputstr,wilds,CWild, CinputWord,MaxInputword,maxwilds,EOS);
        if not Result then
          Inc(cInputWord);
      Until Result or (CinputWord>=MaxinputWord);
      if Result and EOS then
        Exit;
      Continue;
      end;
    if Wilds[CWild] = '?' then { equal to '?' }
      begin
      { goto next letter }
      inc(CWild);
      inc(CinputWord);
      Continue;
      end;
    if inputStr[CinputWord] = Wilds[CWild] then { equal letters }
      begin
      { goto next letter }
      inc(CWild);
      inc(CinputWord);
      Continue;
      end;
    Result:=false;
    Exit;
  until (CinputWord > MaxinputWord) or (CWild > MaxWilds);
  { no completed evaluation, we need to check what happened }
  if (CinputWord <= MaxinputWord) or (CWild < MaxWilds) then
    Result:=false
  else if (CWild>Maxwilds) then
    EOS:=False
  else
    begin
    EOS:=Wilds[CWild]='*';
    if not EOS then
      Result:=False;
    end
end;

function isWild(inputStr, Wilds: string; ignoreCase: boolean): boolean;

var
  i: SizeInt;
  MaxinputWord, MaxWilds: SizeInt; { Length of inputStr and Wilds }
  eos : Boolean;

begin
  Result:=true;
  if Wilds = inputStr then
    Exit;
  { delete '**', because '**' = '*' }
  i:=Pos('**', Wilds);
  while i > 0 do
    begin
    Delete(Wilds, i, 1);
    i:=Pos('**', Wilds);
    end;
  if Wilds = '*' then { for fast end, if Wilds only '*' }
    Exit;
  MaxinputWord:=Length(inputStr);
  MaxWilds:=Length(Wilds);
  if (MaxWilds = 0) or (MaxinputWord = 0) then
    begin
    Result:=false;
    Exit;
    end;
  if ignoreCase then { upcase all letters }
    begin
    inputStr:=AnsiUpperCase(inputStr);
    Wilds:=AnsiUpperCase(Wilds);
    end;
  Result:=isMatch(1,inputStr,wilds,1,1,MaxinputWord, MaxWilds,EOS);
end;


function XorString(const Key, Src: ShortString): ShortString;
var
  i: SizeInt;
begin
  Result:=Src;
  if Length(Key) > 0 then
    for i:=1 to Length(Src) do
      Result[i]:=Chr(Byte(Key[1 + ((i - 1) mod Length(Key))]) xor Ord(Src[i]));
end;

function XorEncode(const Key, Source: string): string;

var
  i: Integer;
  C: Byte;

begin
  Result:='';
  for i:=1 to Length(Source) do
    begin
    if Length(Key) > 0 then
      C:=Byte(Key[1 + ((i - 1) mod Length(Key))]) xor Byte(Source[i])
    else
      C:=Byte(Source[i]);
    Result:=Result+AnsiLowerCase(intToHex(C, 2));
    end;
end;

function XorDecode(const Key, Source: string): string;
var
  i: Integer;
  C: Char;
begin
  Result:='';
  for i:=0 to Length(Source) div 2 - 1 do
    begin
    C:=Chr(StrTointDef('$' + Copy(Source, (i * 2) + 1, 2), Ord(' ')));
    if Length(Key) > 0 then
      C:=Chr(Byte(Key[1 + (i mod Length(Key))]) xor Byte(C));
    Result:=Result + C;
    end;
end;

function GetCmdLineArg(const Switch: string; SwitchChars: TSysCharSet): string;
var
  i: Integer;
  S: string;
begin
  i:=1;
  Result:='';
  while (Result='') and (i<=ParamCount) do
    begin
    S:=ParamStr(i);
    if (SwitchChars=[]) or ((S[1] in SwitchChars) and (Length(S) > 1)) and
       (AnsiCompareText(Copy(S,2,Length(S)-1),Switch)=0) then
      begin
      inc(i);
      if i<=ParamCount then
        Result:=ParamStr(i);
      end;
    inc(i);
    end;
end;

Function RPosEX(C:char;const S : AnsiString;offs:cardinal):SizeInt; overload;

var I   : SizeUInt;
    p,p2: pChar;

Begin
 I:=Length(S);
 If (I<>0) and (offs<=i) Then
   begin
     p:=@s[offs];
     p2:=@s[1];
     while (p2<=p) and (p^<>c) do dec(p);
     RPosEx:=(p-p2)+1;
   end
  else
    RPosEX:=0;
End;

Function RPos(c:char;const S : AnsiString):SizeInt; overload;

var I   : SizeInt;
    p,p2: pChar;

Begin
 I:=Length(S);
 If I<>0 Then
   begin
     p:=@s[i];
     p2:=@s[1];
     while (p2<=p) and (p^<>c) do dec(p);
     i:=p-p2+1;
   end;
  RPos:=i;
End;

Function RPos (Const Substr : AnsiString; Const Source : AnsiString) : SizeInt; overload;
var
  MaxLen,llen : SizeInt;
  c : char;
  pc,pc2 : pchar;
begin
  rPos:=0;
  llen:=Length(SubStr);
  maxlen:=length(source);
  if (llen>0) and (maxlen>0) and ( llen<=maxlen) then
   begin
 //    i:=maxlen;
     pc:=@source[maxlen];
     pc2:=@source[llen-1];
     c:=substr[llen];
     while pc>=pc2 do
      begin
        if (c=pc^) and
           (CompareChar(Substr[1],pchar(pc-llen+1)^,Length(SubStr))=0) then
         begin
           rPos:=pchar(pc-llen+1)-pchar(@source[1])+1;
           exit;
         end;
        dec(pc);
      end;
   end;
end;

Function RPosex (Const Substr : AnsiString; Const Source : AnsiString;offs:cardinal) : SizeInt; overload;
var
  MaxLen,llen : SizeInt;
  c : char;
  pc,pc2 : pchar;
begin
  rPosex:=0;
  llen:=Length(SubStr);
  maxlen:=length(source);
  if SizeInt(offs)<maxlen then maxlen:=offs;
  if (llen>0) and (maxlen>0) and ( llen<=maxlen)  then
   begin
//     i:=maxlen;
     pc:=@source[maxlen];
     pc2:=@source[llen-1];
     c:=substr[llen];
     while pc>=pc2 do
      begin
        if (c=pc^) and
           (CompareChar(Substr[1],pchar(pc-llen+1)^,Length(SubStr))=0) then
         begin
           rPosex:=pchar(pc-llen+1)-pchar(@source[1])+1;
           exit;
         end;
        dec(pc);
      end;
   end;
end;


// def from delphi.about.com:
procedure BinToHex(BinValue, HexValue: PChar; BinBufSize: Integer);

Const
  HexDigits='0123456789ABCDEF';
var
  i : longint;
begin
  for i:=0 to binbufsize-1 do
    begin
    HexValue[0]:=hexdigits[1+((ord(binvalue^) shr 4))];
    HexValue[1]:=hexdigits[1+((ord(binvalue^) and 15))];
    inc(hexvalue,2);
    inc(binvalue);
    end;
end;


function HexToBin(HexValue, BinValue: PChar; BinBufSize: Integer): Integer;
// more complex, have to accept more than bintohex
// A..F    1000001
// a..f    1100001
// 0..9     110000

var i,j,h,l : integer;

begin
  i:=binbufsize;
  while (i>0) do
    begin
    if hexvalue^ IN ['A'..'F','a'..'f'] then
      h:=((ord(hexvalue^)+9) and 15)
    else if hexvalue^ IN ['0'..'9'] then
      h:=((ord(hexvalue^)) and 15)
    else
      break;
    inc(hexvalue);
    if hexvalue^ IN ['A'..'F','a'..'f'] then
      l:=(ord(hexvalue^)+9) and 15
    else if hexvalue^ IN ['0'..'9'] then
      l:=(ord(hexvalue^)) and 15
    else
      break;
    j := l + (h shl 4);
    inc(hexvalue);
    binvalue^:=chr(j);
    inc(binvalue);
    dec(i);
    end;
  result:=binbufsize-i;
end;

function possetex (const c:TSysCharSet;const s : ansistring;count:Integer ):SizeInt;

var i,j:SizeInt;

begin
 if pchar(pointer(s))=nil then
  j:=0
 else
  begin
   i:=length(s);
   j:=count;
   if j>i then
    begin
     result:=0;
     exit;
    end;
   while (j<=i) and (not (s[j] in c)) do inc(j);
   if (j>i) then
    j:=0;                                         // not found.
  end;
 result:=j;
end;

function posset (const c:TSysCharSet;const s : ansistring ):SizeInt;

begin
  result:=possetex(c,s,1);
end;

function possetex (const c:string;const s : ansistring;count:Integer ):SizeInt;

var cset : TSysCharSet;
    i    : SizeInt;
begin
  cset:=[];
  if length(c)>0 then
  for i:=1 to length(c) do
    include(cset,c[i]);
  result:=possetex(cset,s,count);
end;

function posset (const c:string;const s : ansistring ):SizeInt;

var cset : TSysCharSet;
    i    : SizeInt;
begin
  cset:=[];
  if length(c)>0 then
    for i:=1 to length(c) do
      include(cset,c[i]);
  result:=possetex(cset,s,1);
end;


Procedure Removeleadingchars(VAR S : AnsiString; Const CSet:TSysCharset);

VAR I,J : Longint;

Begin
 I:=Length(S); 
 IF (I>0) Then
  Begin
   J:=1;
   While (J<=I) And (S[J] IN CSet) DO 
     INC(J);
   IF J>1 Then
    Delete(S,1,J-1);
   End;
End;


function TrimLeftSet(const S: String;const CSet:TSysCharSet): String;

begin
  result:=s;
  removeleadingchars(result,cset); 
end;

Procedure RemoveTrailingChars(VAR S : AnsiString;Const CSet:TSysCharset);

VAR I,J: LONGINT;

Begin
 I:=Length(S);
 IF (I>0) Then
  Begin
   J:=I;
   While (j>0) and (S[J] IN CSet) DO DEC(J);
   IF J<>I Then
    SetLength(S,J);
  End;
End;

Function TrimRightSet(const S: String;const CSet:TSysCharSet): String;

begin
  result:=s;
  RemoveTrailingchars(result,cset); 
end;

Procedure RemovePadChars(VAR S : AnsiString;Const CSet:TSysCharset);

VAR I,J,K: LONGINT;

Begin
 I:=Length(S);
 IF (I>0) Then
  Begin
   J:=I;
   While (j>0) and (S[J] IN CSet) DO DEC(J);
   if j=0 Then
     begin 
       s:='';
       exit;
     end;
   k:=1;
   While (k<=I) And (S[k] IN CSet) DO 
     INC(k);
   IF k>1 Then
     begin
       move(s[k],s[1],j-k+1);
       setlength(s,j-k+1);
     end
   else
     setlength(s,j);  
  End;
End;

function TrimSet(const S: String;const CSet:TSysCharSet): String;

begin
  result:=s;
  RemovePadChars(result,cset); 
end;


end.
