{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit Unit1;

interface

uses
  Windows, SysUtils, Graphics, Classes, Forms, Controls,
  Dialogs, StdCtrls, ExtCtrls, XPMan, INIFiles, Clipbrd,
  vidframe, GraphicEx, GR32, GR32_Image, GR32_Layers, GR32_Filters,
  ComCtrls;

type
  TForm1 = class(TForm)
    pnlControls: TPanel;
    OpenDialog1: TOpenDialog;
    XPManifest1: TXPManifest;
    SaveDialog1: TSaveDialog;
    btnSave: TButton;
    btnCopy: TButton;
    imgvwStitch: TImgView32;
    btnAutoStitch32: TButton;
    StatusBar1: TStatusBar;
    tmrStats: TTimer;
    cbFollowStitch: TCheckBox;
    PageControl: TPageControl;
    tsInputs: TTabSheet;
    tsSettings: TTabSheet;
    tsGraph: TTabSheet;
    tsLog: TTabSheet;
    lblFilename: TLabel;
    lblFirstFrame: TLabel;
    lblToFrame: TLabel;
    lblDecimate: TLabel;
    edtFilename: TEdit;
    btnBrowseFilename: TButton;
    cbUseMask: TCheckBox;
    edtMask: TEdit;
    btnBrowseMask: TButton;
    edtFirstFrame: TEdit;
    edtLastFrame: TEdit;
    btnAllFrames: TButton;
    cbReverseOrder: TCheckBox;
    edtDecimateFrameRate: TEdit;
    lblSearchDistance: TLabel;
    lblBadMatch: TLabel;
    lblGoodPercent: TLabel;
    lblGoodMatch: TLabel;
    lblBadPercent: TLabel;
    lblScrolling: TLabel;
    lblSearchDistUnits: TLabel;
    lblExpand: TLabel;
    Label2: TLabel;
    edtPixelSearchDist: TEdit;
    edtBadMatchThreshold: TEdit;
    edtGoodMatchThreshold: TEdit;
    cmbScrollingType: TComboBox;
    cbDrop00: TCheckBox;
    edtExpand: TEdit;
    imgGraph: TImage;
    Memo1: TMemo;
    cbCrop: TCheckBox;
    lblCropTop: TLabel;
    edtCropTop: TEdit;
    lblCropLeft: TLabel;
    edtCropLeft: TEdit;
    lblCropWidth: TLabel;
    edtCropWidth: TEdit;
    lblCropHeight: TLabel;
    edtCropHeight: TEdit;
    btnResetCrop: TButton;
    cbResetCropOnLoad: TCheckBox;
    cbResetFramesOnLoad: TCheckBox;
    Label1: TLabel;
    edtBGFill: TEdit;
    shBGFill: TShape;
    procedure btnBrowseFilenameClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCopyClick(Sender: TObject);
    procedure btnBrowseMaskClick(Sender: TObject);
    procedure btnAutoStitch32Click(Sender: TObject);
    procedure btnAllFramesClick(Sender: TObject);
    procedure StatusBar1Resize(Sender: TObject);
    procedure tmrStatsTimer(Sender: TObject);
    procedure imgvwStitchMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure imgvwStitchMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure btnResetCropClick(Sender: TObject);
    procedure edtBGFillChange(Sender: TObject);
  private
    { Private declarations }
//    procedure DoShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo);

    procedure UpdateStatusBar(currFrame, w, h, max:integer);
  public
    { Public declarations }
  end;

  IFrameServer = interface
    function load(filename: String):Boolean;
    function getNumImages:Integer;
    function getWidth:Integer;
    function getHeight:Integer;
    procedure getOneFrame(index:integer; var dest: TBitmap32); overload;
    function canHandleExt(ext:String):boolean;
  end;

  TBitmapFrameServer = class(TInterfacedObject, IFrameServer)
  public
    function load(filename: String):Boolean;
    function getNumImages:Integer;
    function getWidth:Integer;
    function getHeight:Integer;
    procedure getOneFrame(index:integer; var dest: TBitmap32); overload;
    function canHandleExt(ext:String):boolean;
    destructor Destroy; override;
  private
    filenames:TStringList;
    m_width, m_height: integer;
    procedure getWH;
  end;

  TAviFrameServer = class(TInterfacedObject, IFrameServer)
  public
    function load(filename: String):Boolean;
    function getNumImages:Integer;
    function getWidth:Integer;
    function getHeight:Integer;
    procedure getOneFrame(index:integer; var dest: TBitmap32); overload;
    function canHandleExt(ext:String):boolean;
    destructor Destroy; override;
  private
  end;


var
  Form1: TForm1;
  calculating:boolean;
  blankcolour:TColor32;
  frameserver:IFrameServer;
  numFramesInLastInterval,dragStartX,dragStartY: integer;

implementation

uses StrUtils, Types;

{$R *.dfm}

// Natural sort algorithm
// 1. String number splitter
function getparts(s:string;var prefix:string;var number:integer;var suffix:string):boolean;
var
  b,e:integer;
begin
  // find the last digit in the string
  e:=length(s);
  while ((s[e] < '0') or (s[e] > '9')) and (e>0) do Dec(e);

  // if there was no number, return false
  if (e=0) then begin
    result:=false;
    exit;
  end;

  // find the start of that run of digits
  b:=e;
  while (s[b] >= '0') and (s[b] <= '9') and (b>=1) do Dec(b);

  // fill in the prefix, etc
  prefix:=copy(s,1,b);
  number:=StrToInt(copy(s,b+1,e-b));
  suffix:=copy(s,e+1,MaxInt);
  result:=true;
end;

// 2. Natural string comparison function
function forwardsort(sl:TStringlist;i1,i2:integer):integer;
var
  prefix1,suffix1,prefix2,suffix2:string;
  number1,number2:integer;
begin
  if (getparts(sl[i1],prefix1,number1,suffix1) and getparts(sl[i2],prefix2,number2,suffix2)) then begin
    result:=CompareStr(prefix1,prefix2);
    if result=0 then result:=number1-number2;
    if result=0 then result:=CompareStr(suffix1,suffix2);
  end else begin
    result:=CompareStr(sl[i1],sl[i2]);
  end;
end;

// 3. Inverse comparison function
function reversesort(sl:TStringlist;i1,i2:integer):integer;
begin
  result:=-forwardsort(sl,i1,i2);
end;

// BitmapFrameServer class
function TBitmapFrameServer.load(filename: String):Boolean;
var
  path,prefix,suffix,pattern:string;
  i:integer;
  sr:TSearchRec;
begin
  filenames:=TStringList.Create;
  path:=ExtractFilePath(filename);
  // See if it's numbered
  if getparts(filename,prefix,i,suffix) then begin
    // it's numbered
    // so try to match a little more closely
    pattern:=prefix+'*'+suffix;
  end else begin
    // it's just a filename, so grab all the files
    pattern:=path+'*'+ExtractFileExt(filename);
  end;
  if FindFirst(pattern,faAnyFile,sr)=0 then repeat
    filenames.Add(path+sr.Name);
  until FindNext(sr)<>0;
  FindClose(sr);

  // Sort the files
  filenames.CustomSort(forwardsort);

  result:=true;
end;

function TBitmapFrameServer.getNumImages:Integer;
begin
  result:=filenames.Count;
end;

function TBitmapFrameServer.getWidth:Integer;
begin
  if (m_width = 0) then getWH;
  result := m_width;
end;

function TBitmapFrameServer.getHeight:Integer;
begin
  if (m_height = 0) then getWH;
  result := m_height;
end;

procedure TBitmapFrameServer.getWH;
var
  bm:TBitmap32;
begin
  bm:=TBitmap32.Create;
  bm.LoadFromFile(filenames[0]);
  m_width := bm.Width;
  m_height := bm.Height;
  bm.Free;
end;

procedure TBitmapFrameServer.getOneFrame(index:integer; var dest: TBitmap32);
begin
  dest.LoadFromFile(filenames[index]);
end;

function TBitmapFrameServer.canHandleExt(ext:String):boolean;
begin
  result := Pos(ext,'.bmp.gif.png.tiff.tga.pcx.ppm.pbm')>0;
end;

destructor TBitmapFrameServer.Destroy;
begin
  filenames.Free;
end;

// AviFrameServer class
function TAviFrameServer.load(filename: String):Boolean;
begin
  vidframe.closeVideo;
  vidframe.openDirectShow(filename);
  result:=true;
end;

function TAviFrameServer.getNumImages:Integer;
begin
  result:=vidframe.getFrameCount;
end;

function TAviFrameServer.getWidth:Integer;
begin
  result:=vidframe.getWidth;
end;

function TAviFrameServer.getHeight:Integer;
begin
  result:=vidframe.getHeight;
end;

procedure TAviFrameServer.getOneFrame(index:integer; var dest: TBitmap32);
begin
  vidframe.getFrame(index);
  dest.Assign(vidframe.frameBM);
end;

function TAviFrameServer.canHandleExt(ext:String):boolean;
begin
  if (ext = '.avi') then result:=true
  else result:=false;
end;

destructor TAviFrameServer.Destroy;
begin
  vidframe.closeVideo;
end;

procedure TryToLoadFile(fn:string);
var
  fnext:string;
begin
  fnext:=LowerCase(ExtractFileExt(fn));

  frameserver:=TBitmapFrameServer.Create();
  if not frameserver.canHandleExt(fnext) then begin
    frameserver:=TAviFrameServer.Create();
    if not frameserver.canHandleExt(fnext) then begin
      frameserver := nil;
    end;
  end;

  if (frameserver <> nil) and frameserver.load(fn) then begin
    form1.Memo1.Lines.Add(IntToStr(frameserver.getNumImages)+' frames available');
    form1.Memo1.Lines.Add('Frame size: '+IntToStr(frameserver.getWidth)+'x'+IntToStr(frameserver.getHeight));
  end else begin
    frameserver:=nil;
  end;
end;


procedure TForm1.btnBrowseFilenameClick(Sender: TObject);
begin
  OpenDialog1.FileName:=edtFilename.Text;
  if OpenDialog1.Execute then begin
    edtFilename.Text:=OpenDialog1.FileName;
    TryToLoadFile(OpenDialog1.FileName);
    if (frameserver <> nil) then begin
      if (cbResetCropOnLoad.Checked) then btnResetCrop.Click;
      if (cbResetFramesOnLoad.Checked) then btnAllFrames.Click;
    end;
  end;
end;

procedure UpdateGraph(matchpercentage:real;matchx,matchy:integer);
const
{$J+} // assignable consts to be like static
  lastcounty:integer = 0;
  lastxy:integer = 0;
  lastyy:integer = 0;
  countaxisy:integer = 0;
  xaxisy:integer = 0;
  yaxisy:integer = 0;
  gwidth:integer = 0;
  counter:integer = 0;
{$J-}
  awidth:integer = 20;
var
  y:integer;
begin
  with Form1.imgGraph.Picture.Bitmap do begin
    if width<>Form1.imgGraph.Width then begin
      // init
      Width:=Form1.imgGraph.Width;
      Height:=Form1.imgGraph.Height;
      PixelFormat:=pf32bit;
      canvas.Brush.Color:=clBlack;
      canvas.FillRect(Rect(0,0,width,height));
      // draw axes
      countaxisy:=height div 2;
      xaxisy:=countaxisy + countaxisy div 4;
      yaxisy:=xaxisy + countaxisy div 2;
      gwidth:=width - awidth;
      canvas.pen.Color:=clGray;
      canvas.MoveTo(awidth,0);
      canvas.LineTo(awidth,height);
      canvas.MoveTo(awidth,countaxisy);
      Canvas.LineTo(width,countaxisy);
      canvas.MoveTo(awidth,xaxisy);
      Canvas.LineTo(width,xaxisy);
      canvas.MoveTo(awidth,yaxisy);
      Canvas.LineTo(width,yaxisy);
    end;

    // shift graphs
    Canvas.CopyRect(Rect(awidth+1,0,width,height),Canvas,Rect(awidth+2,0,width+1,height));

    // draw current match level on graph
    canvas.pen.Color:=clGreen;
    Canvas.MoveTo(width-3,countaxisy - lastcounty);
    y:=Round((matchpercentage-90) / 10 * countaxisy);
    Canvas.LineTo(width-2,countaxisy - y);
    lastcounty:=y;

    // draw x,y on graph
    canvas.pen.Color:=clMaroon;
    Canvas.MoveTo(width-3,xaxisy-lastxy);
    Canvas.LineTo(width-2,xaxisy-matchx);
    lastxy:=matchx;
    canvas.pen.Color:=clNavy;
    Canvas.MoveTo(width-3,yaxisy-lastyy);
    Canvas.LineTo(width-2,yaxisy-matchy);
    lastyy:=matchy;
  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  copy:TBitmap32;
begin
  if SaveDialog1.Execute then begin
    // make transparent background coloured
    copy := TBitmap32.Create;
    try
      with copy do begin
        Assign(imgvwStitch.Bitmap);
        FillRect(0,0,width,height,BlankColour);
        Draw(0, 0, imgvwStitch.Bitmap);
      end;
      copy.SaveToFile(SaveDialog1.filename);
    finally
      copy.Free;
    end;
  end;
end;
{
procedure TForm1.DoShowHint(var HintStr: String; var CanShow: Boolean; var HintInfo: THintInfo);
begin
  // Not done
  if HintInfo.HintControl = Image2 then begin
    HintInfo.CursorRect.Right:=HintInfo.CursorRect.Left;
    HintInfo.CursorRect.Bottom:=HintInfo.CursorRect.Top;
    // get data
    HintStr:='Hello world';
  end;
end;}

procedure TForm1.FormShow(Sender: TObject);
begin
  Application.Title:=Form1.Caption;
  with TINIFile.Create(ChangeFileExt(ParamStr(0),'.ini')) do begin
    edtFilename.Text:=ReadString('Settings','Last file','');
    edtFirstFrame.Text:=ReadString('Settings','First frame','');
    edtLastFrame.Text:=ReadString('Settings','Last frame','');
    edtPixelSearchDist.Text:=ReadString('Settings','Pixel search distance','16');
    edtBadMatchThreshold.Text:=ReadString('Settings','Bad match threshold','50');
    edtGoodMatchThreshold.Text:=ReadString('Settings','Good match threshold','95');
    edtDecimateFramerate.Text:=ReadString('Settings','Decimate frame rate','1');
    edtMask.Text:=ReadString('Settings','Last mask','');
    Form1.Left:=ReadInteger('Position','Left',100);
    Form1.Top:=ReadInteger('Position','Top',100);
    Form1.Width:=ReadInteger('Position','Width',600);
    Form1.Height:=ReadInteger('Position','Height',600);
    Form1.WindowState:=TWindowState(ReadInteger('Position','State',Integer(wsNormal)));
    edtBGFill.Text:=ReadString('Settings','Blank colour','ff00ff');
    cbReverseOrder.Checked:=ReadBool('Settings','Reverse order',false);
    cbUseMask.Checked:=ReadBool('Settings','Use mask',false);
    cmbScrollingType.ItemIndex:=ReadInteger('Settings','Scrolling goes',0);
    cbDrop00.Checked:=ReadBool('Settings','Drop 0,0 matches',false);
    cbFollowStitch.Checked:=ReadBool('Settings','Follow stitch',true);
    cbCrop.Checked:=ReadBool('Settings','Crop image',false);
    edtCropTop.Text:=ReadString('Settings','Crop top','');
    edtCropLeft.Text:=ReadString('Settings','Crop left','');
    edtCropWidth.Text:=ReadString('Settings','Crop width','');
    edtCropHeight.Text:=ReadString('Settings','Crop height','');
    cbResetFramesOnLoad.Checked:=ReadBool('Settings','Reset frames on load',true);
    cbResetCropOnLoad.Checked:=ReadBool('Settings','Reset crop on load',true);
  end;

  PageControl.TabIndex:=0;

//  Application.OnShowHint:=DoShowHint;
//  Application.HintPause:=1;
//  Application.HintHidePause:=20000;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (calculating) then calculating := false;
  with TINIFile.Create(ChangeFileExt(ParamStr(0),'.ini')) do begin
    WriteString('Settings','Last file',edtFilename.Text);
    WriteString('Settings','First frame',edtFirstFrame.Text);
    WriteString('Settings','Last frame',edtLastFrame.Text);
    WriteString('Settings','Pixel search distance',edtPixelSearchDist.Text);
    WriteString('Settings','Bad match threshold',edtBadMatchThreshold.Text);
    WriteString('Settings','Good match threshold',edtGoodMatchThreshold.Text);
    WriteString('Settings','Decimate frame rate',edtDecimateFramerate.Text);
    WriteString('Settings','Last mask',edtMask.Text);
    WriteInteger('Position','State',integer(Form1.WindowState));
    Form1.WindowState:=wsNormal;
    WriteInteger('Position','Left',Form1.Left);
    WriteInteger('Position','Top',Form1.Top);
    WriteInteger('Position','Width',Form1.Width);
    WriteInteger('Position','Height',Form1.Height);
    WriteString('Settings','Blank colour',IntToHex(blankcolour,6));
    WriteBool('Settings','Reverse order',cbReverseOrder.Checked);
    WriteBool('Settings','Use mask',cbUseMask.Checked);
    WriteInteger('Settings','Scrolling goes',cmbScrollingType.ItemIndex);
    WriteBool('Settings','Drop 0,0 matches',cbDrop00.Checked);
    WriteBool('Settings','Follow stitch',cbFollowStitch.Checked);
    WriteBool('Settings','Crop image',cbCrop.Checked);
    WriteString('Settings','Crop top',edtCropTop.Text);
    WriteString('Settings','Crop left',edtCropLeft.Text);
    WriteString('Settings','Crop width',edtCropWidth.Text);
    WriteString('Settings','Crop height',edtCropHeight.Text);
    WriteBool('Settings','Reset frames on load',cbResetFramesOnLoad.Checked);
    WriteBool('Settings','Reset crop on load',cbResetCropOnLoad.Checked);
  end;
end;

procedure TForm1.btnCopyClick(Sender: TObject);
var
  copy:TBitmap32;
begin
  // make transparent background coloured
  copy := TBitmap32.Create;
  try
    with copy do begin
      Assign(imgvwStitch.Bitmap);
      FillRect(0,0,width,height,BlankColour);
      Draw(0, 0, imgvwStitch.Bitmap);
    end;
    Clipboard.Assign(copy);
  finally
    copy.Free;
  end;
end;

procedure TForm1.btnBrowseMaskClick(Sender: TObject);
begin
  OpenDialog1.FileName:=edtMask.Text;
  if OpenDialog1.Execute then edtMask.Text:=OpenDialog1.FileName;
end;

// Count non-matching pixels for the given placement
function GetMatchQuality32(dest, src: TBitmap32; x, y, giveupat: integer):integer;
var
  sx,sy:integer;
  ps,pd:TColor32Entry;
begin
  result:=0;

  for sy:=0 to src.Height-1 do begin
    for sx:=0 to src.width-1 do begin
      ps := TColor32Entry(src.Pixel[sx, sy]);
      pd := TColor32Entry(dest.Pixel[sx+x, sy+y]);
      if (ps.A = 255)   // src is opaque
      and (pd.A = 255)  // dest is opaque
      and (ps.ARGB <> pd.ARGB)    // src != dest
      then Inc(Result);

      if (Result > giveupat) then exit;
    end;
  end;
end;

function TryPlacement32(dest, src: TBitmap32; x, y: integer; var bestmatch: integer; var bestx: integer; var besty: integer; stopthreshold, lastx, lasty, range:integer):boolean;
var
  match:integer;
begin
  if (abs(x-lastx)>range)
  or (abs(y-lasty)>range)
  then begin
    result:=false;
    exit;
  end;

  match:=GetMatchQuality32(dest,src,x,y,bestmatch);
//  form1.Memo1.lines.add(format('at %d,%d: %d',[x,y,match]));
  if match<bestmatch then begin
    bestx:=x;
    besty:=y;
    bestmatch:=match;
  end;
  result:=match<stopthreshold;
end;

procedure FindBestPlacement32(dest,src:TBitmap32;lastx,lasty:integer;var bestx,besty:integer;range,matchthreshold,stopthreshold:integer;doh,dov,drop00:boolean);
const
{$J+} // assignable consts to be like static
  lastdx:integer = 0;
  lastdy:integer = 0;
{$J-}
var
  bestmatch:integer;
  x,y,dist,min,max,nx,ny,ex,ey,sx,sy,wx,wy,i:integer;
  matchpercentage:real;
begin
  bestmatch:=matchthreshold;

  // if drop 0,0 enabled then try 0,0 first
  // can end up checking it twice this way...
  if not (drop00 and TryPlacement32(dest,src,lastx,lasty,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range))
  then begin
    // now generate the sequence
    x:=lastx+lastdx;
    y:=lasty+lastdy;
    for dist:=0 to range*2 do begin
      if dist=0 then begin
        if TryPlacement32(dest,src,x,y,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range) then break;
      end else begin
        if doh and dov then begin
          // this algorithm tries to find close, compass-point-ish matches first
          // I want to start at NSEW and extend out
          // avoid double-counting corners by doing 1 less on top+bottom

          // extend out
          nx:=x;
          ny:=y-dist;
          ex:=x+dist;
          ey:=y;
          sx:=x;
          sy:=y+dist;
          wx:=x-dist;
          wy:=y;

          // check them
          if TryPlacement32(dest,src,nx,ny,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
          or TryPlacement32(dest,src,ex,ey,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
          or TryPlacement32(dest,src,sx,sy,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
          or TryPlacement32(dest,src,wx,wy,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range) then break;

          // count away from the compass points
          // count away 1 less on the downside to avoid double-counting corners
          // length of side is dist*2+1
          min:=dist-1;
          max:=dist;
          for i:=1 to max do begin
            if TryPlacement32(dest,src,nx+i,ny,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
            or TryPlacement32(dest,src,ex,ey+i,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
            or TryPlacement32(dest,src,sx-i,sy,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
            or TryPlacement32(dest,src,wx,wy-i,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range) then break;
            if i<=min then begin
              if TryPlacement32(dest,src,nx-i,ny,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
              or TryPlacement32(dest,src,ex,ey-i,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
              or TryPlacement32(dest,src,sx+i,sy,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
              or TryPlacement32(dest,src,wx,wy+i,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range) then break;
            end;
          end;
          if bestmatch<stopthreshold then break;
        end else if doh = false then begin
          // vertical
          for i:=1 to dist do
            if TryPlacement32(dest,src,x,y-i,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
            or TryPlacement32(dest,src,x,y+i,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
            then break;

          if bestmatch<stopthreshold then break;
        end else begin
          // horizontal
          for i:=1 to dist do
            if TryPlacement32(dest,src,x-i,y,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
            or TryPlacement32(dest,src,x+i,y,bestmatch,bestx,besty,stopthreshold,lastx,lasty,range)
            then break;

          if bestmatch<stopthreshold then break;
        end;
      end;
    end;
  end;

  if bestmatch>=matchthreshold then begin
    Form1.Memo1.Lines.Add('Discarding due to bad match');
    bestx:=-1000;
    besty:=-1000;
  end else begin
    lastdx:=bestx-lastx;
    lastdy:=besty-lasty;

    matchpercentage:=(1-bestmatch/(src.width*src.height))*100;
    Form1.Memo1.Lines.Add(Format('Best match at %d,%d: %.3f%% pixels matched',[lastdx,lastdy,matchpercentage]));

    if (lastdx = 0) and (lastdy = 0) and drop00 then begin
      bestx:=-1000;
      besty:=-1000;
      Form1.Memo1.Lines.Add('Discarding!');
    end else begin
      UpdateGraph(matchpercentage,lastdx,lastdy);
    end;
  end;
end;

function GetVisibleRect: TRect;
var
  bmrect:TRect;
  viewport:TRect;
begin
  // get the location of the bitmap
  bmrect := form1.imgvwStitch.GetBitmapRect;
  viewport := form1.imgvwStitch.GetViewportRect; // doesn't change much but never mind
  //    +------------------+
  //    |  O               |
  //    |   +--------+     |
  //    |   |        |  BM |
  //    |   |  VP    |     |
  //    |   +--------+     |
  //    +------------------+
  // both rects have origin at O
  // I want the origin at the top-left
  // and to get VP out
  result := viewport;
  OffsetRect(result, -bmrect.Left, -bmrect.Top);
//  result.Left   := viewport.Left - bmrect.Left;
//  result.Top    := viewport.Top  - bmrect.Top;
//  result.Right  := result.Left + viewport.Right - viewport.Left;
//  result.Bottom := result.Top + viewport.Bottom - viewport.Top;
end;

procedure MakeRectVisible(r:TRect);//x,y,w,h:integer);
var
  viewport:TRect;
  dx, dy: integer;
begin
  viewport := GetVisibleRect();

  // figure out the adjustment it now needs to encompass the newly added image
  dx := 0;
  dy := 0;
  // adjust its left, top to fit the dimensions
  if (viewport.Right  < r.Right) then dx := r.Right  - viewport.Right;
  if (viewport.Bottom < r.Bottom)then dy := r.Bottom - viewport.Bottom;
  // do these last so the top left is aligned when the viewport is smaller than the image
  if (viewport.Left  > r.Left) then dx := r.Left - viewport.Left;
  if (viewport.Top   > r.Top ) then dy := r.Top  - viewport.Top;

  if (dx = 0) and (dy = 0) then exit;
  form1.imgvwStitch.Scroll(dx, dy);
end;

procedure PlaceImage32(dest, src:TBitmap32;var x:integer;var y:integer;searchdist, border:integer);
var
  dx,dy,l,t:integer;
  temp:TBitmap32;
  viewport:TRect;
begin
  // Enlarge canvas if x,y outside safe bounds
  l:=0;  // left
  t:=0;  // top
  dx:=0; // x expansion
  dy:=0; // y expansion
  if (dest.width < src.Width) then begin
    // not wide enough
    dx:=src.width;
  end;
  if (dest.Height < src.Height) then begin
    // not tall enough
    dy:=src.Height;
  end;
  if(x<searchdist) then begin
    // too close on left
    dx:=dx+border;
    l:=border;
  end;
  if(y<searchdist) then begin
    // too close on top
    dy:=dy+border;
    t:=border;
  end;
  if(x+src.width>dest.width-searchdist) then begin
    // too close on right
    dx:=dx+border;
  end;
  if(y+src.height>dest.height-searchdist) then begin
    // too close on bottom
    dy:=dy+border;
  end;

  if (dx>0)or(dy>0)or(l>0)or(t>0) then begin
    // enlarge
    Form1.Memo1.Lines.Add(Format('Enlarging canvas from %dx%d to %dx%d, left=%d,top=%d',[dest.Width,dest.height,dest.Width+dx,dest.height+dy,l,t]));

    // maintain the scroll position as we resize
    // nasty to do this here :(
    viewport := getVisibleRect;
    OffsetRect(viewport, l, t);

    // copy BM
    temp:=TBitmap32.Create;
    temp.Assign(dest);

    // resize original (erases)
    dest.SetSize(dest.width+dx, dest.height+dy);

    // maintain scroll position
    MakeRectVisible(viewport);

    // draw copy back to it
    dest.Draw(l, t, temp);

    // dispose of copy
    temp.Free;

    // adjust x, y for new BM coordinates
    x:=x+l;
    y:=y+t;
  end;

  // draw it on
  dest.Draw(x,y,src);
end;

// Applies low 8 bits of src as alpha value for dst
// assumes they're the same size
procedure ApplyMask(Dst, Src: TBitmap32);
var
  I: Integer;
  D, S: PColor32;
begin
  D := @Dst.Bits[0];
  S := @Src.Bits[0];
  for I := 0 to Src.Width * Src.Height - 1 do
  begin
    D^ := (D^ and $ffffff) or (S^ shl 24);
    Inc(S); Inc(D);
  end;
end;


procedure TForm1.btnAutoStitch32Click(Sender: TObject);
var
  tc: Cardinal;
  fn: string;
  matchthreshold, stopthreshold: double;
  imatchthreshold, istopthreshold: integer;
  startframe, endframe: integer;
  limit, decimate, expand: integer;
  doh, dov, domask, reverse: boolean;
  lastx, lasty: integer;
  imgsdone, currentframe: integer;
  imgnum: integer;
  firstframe: boolean;
  mask, img: TBitmap32;
  x, y: integer;
  msg:string;
  docrop: boolean;
  cropl, cropt, cropw, croph: integer;
  tempBM:TBitmap32;
  maxdistance: integer;
begin
  if calculating then begin
    calculating:=false;
    exit;
  end;

  tc:=gettickcount;

  StatusBar1.Panels[0].Text:='Stitching... Press button again to cancel. Check log if nothing happens.';

  if (frameserver=nil) then TryToLoadFile(edtFilename.Text);
  if (frameserver=nil) then begin
    Memo1.Lines.Add('ERROR: Unable to load '+edtFilename.Text);
    exit;
  end;

  imgGraph.Picture.Bitmap.Width:=0;
  imgGraph.Picture.Bitmap.Height:=0;

  imgvwStitch.Bitmap.Width:=0;
  imgvwStitch.Bitmap.Height:=0;
  imgvwStitch.Bitmap.Clear($00ff00ff);

  // supress warnings
  imatchthreshold:=0;
  istopthreshold:=0;

  maxdistance:=0;

  fn:=edtFilename.Text;

  startframe:=StrToIntDef(edtFirstFrame.Text,-1);
  endframe:=StrToIntDef(edtLastFrame.Text,-1);
  if (startframe<0) or (startframe>frameserver.getNumImages-2) then begin
    Memo1.Lines.Add('ERROR: first frame out of range (0-'+IntToStr(frameserver.getNumImages-2)+')');
    exit;
  end;
  if (endframe<startframe+1) or (endframe>=frameserver.getNumImages) then begin
    Memo1.Lines.Add('ERROR: last frame out of range ('+IntToStr(startframe+1)+'-'+IntToStr(frameserver.getNumImages-1)+')');
    exit;
  end;
  limit:=StrToIntDef(edtPixelSearchDist.Text,-1);
  if (limit<1) or (limit>100) then begin
    Memo1.Lines.Add('ERROR: Search distance out of range (max 100)');
    exit;
  end;
  matchthreshold:=StrToFloatDef(edtBadMatchThreshold.Text,-1);
  if (matchthreshold<1) or (matchthreshold > 100) then begin
    Memo1.Lines.Add('ERROR: Bad match threshold out of range (1-100)');
    exit;
  end;
  stopthreshold:=StrToFloatDef(edtGoodMatchThreshold.Text,-1);
  if (stopthreshold<1) or (stopthreshold > 100) or (stopthreshold < matchthreshold) then begin
    Memo1.Lines.Add('ERROR: Good match threshold out of range (1-100, >bad threshold)');
    exit;
  end;
  decimate:=StrToIntDef(edtDecimateFramerate.Text,-1);
  if (decimate<1) or (decimate > 100) then begin
    Memo1.Lines.Add('ERROR: Decimate value out of range (1-100)');
    exit;
  end;
  expand:=StrToIntDef(edtExpand.Text,-1);
  if (expand<limit) or (expand>1000) then begin
    Memo1.Lines.Add('ERROR: Expand distance must be <1000 and at least equal to the search distance');
    exit;
  end;
  cropl:=StrToIntDef(edtCropLeft.Text,-1);
  if (cropl<0) then begin
    Memo1.Lines.Add('ERROR: crop left must be > 0');
    exit;
  end;
  cropt:=StrToIntDef(edtCropTop.Text,-1);
  if (cropt<0) then begin
    Memo1.Lines.Add('ERROR: crop top must be > 0');
    exit;
  end;
  cropw:=StrToIntDef(edtCropWidth.Text,-1);
  if (cropw<0) then begin
    Memo1.Lines.Add('ERROR: crop width must be > 0');
    exit;
  end;
  if (cropw+cropl>frameserver.getWidth) then begin
    Memo1.Lines.Add('ERROR: crop left + width wider than the frame');
    exit;
  end;
  croph:=StrToIntDef(edtCropHeight.Text,-1);
  if (croph<0) then begin
    Memo1.Lines.Add('ERROR: crop height must be > 0');
    exit;
  end;
  if (croph+cropt>frameserver.getHeight) then begin
    Memo1.Lines.Add('ERROR: crop top + height taller than the frame');
    exit;
  end;
  docrop:=cbCrop.Checked;

  case cmbScrollingType.ItemIndex of
  0:begin
    doh:=true;
    dov:=true;
  end;
  1:begin
    doh:=true;
    dov:=false;
  end;
  2:begin
    doh:=false;
    dov:=true;
  end;
  else
    Memo1.Lines.Add('ERROR: invalid scrolling value');
    exit;
  end;

  calculating:=true;

  reverse:=cbReverseOrder.Checked;

  domask:=cbUseMask.Checked;

  mask := TBitmap32.Create();
  if domask then begin
    if not FileExists(edtMask.Text) then begin
      Memo1.Lines.Add('ERROR: Mask image not found');
      exit;
    end;
    mask.LoadFromFile(edtMask.Text);
  end;

  lastx:=0;
  lasty:=0;
  imgsdone:=0;
  firstframe:=true;
  // For all frames...
  for imgnum:=startframe to endframe do begin
    if (imgnum mod decimate)<>0 then continue;

    if (reverse)
    then currentframe:=endframe+startframe-imgnum
    else currentframe:=imgnum;
    Memo1.Lines.Add('Frame #'+IntToStr(currentframe));

    if img=nil then begin
      img:=TBitmap32.Create;
      img.DrawMode:=dmBlend;
    end;
    if (docrop) then begin
      // get the image to a temp bitmap
      if (tempBM=nil) then tempBM:=TBitmap32.Create;
      frameserver.getOneFrame(currentframe, tempbm);
      // draw onto img
      img.SetSize(cropw, croph);
      img.Draw(0,0,Rect(cropl,cropt,cropl+cropw, cropt+croph),tempBM);
    end else begin
      // no cropping, just get the img
      frameserver.getOneFrame(currentframe, img);
    end;
    if (domask) then begin
      // apply the mask
      ApplyMask(img, mask);
      // adjust the thresholds?
    end;

    if firstframe then begin
      // 1st img: just place it
      x:=0;
      y:=0;
      // fix up thresholds from percentages to pixel counts
      imatchthreshold:=Round(img.Width * img.Height * (1 - matchthreshold / 100));
      istopthreshold:=Round(img.Width * img.Height * (1 - stopthreshold / 100));
      firstframe:=false;
    end else begin
      // Following images: paste over the top and check if they match
      FindBestPlacement32(imgvwStitch.Bitmap,img,lastx,lasty,x,y,limit,imatchthreshold,istopthreshold,doh,dov,cbDrop00.checked);
    end;

    if(x>-1)and(y>-1)
    then begin
      if ((x - lastx) > maxdistance) then maxdistance := (x - lastx);
      if ((y - lasty) > maxdistance) then maxdistance := (y - lasty);
      if ((lastx - x) > maxdistance) then maxdistance := (lastx - x);
      if ((lasty - y) > maxdistance) then maxdistance := (lasty - y);

      PlaceImage32(imgvwStitch.Bitmap,img,x,y,limit,expand);
      Inc(imgsdone);
      Inc(numFramesInLastInterval);

      UpdateStatusBar(imgnum, imgvwStitch.Bitmap.Width, imgvwStitch.Bitmap.Height, maxdistance);
      if (cbFollowStitch.Checked) then MakeRectVisible(Rect(x,y,x+img.Width,y+img.Height));
    end;

    Application.ProcessMessages;

    if (x>0) and (y>0) then begin
      lastx:=x;
      lasty:=y;
    end;

    if not calculating then break;
  end;

  tc:=gettickcount-tc;
  if tc=0 then tc:=1;
  msg:=format('All done in roughly %fs, %ffps',[tc/1000,imgsdone/(tc/1000)]);
  memo1.lines.add(msg);
  StatusBar1.Panels[0].Text:=msg;

  // interface magic means this virtually destructs the object
  frameserver:=nil;
  if (tempBM<>nil) then tempBM.Free;
  img.free;
  mask.free;
  calculating:=false;
end;

procedure TForm1.btnAllFramesClick(Sender: TObject);
begin
  if (frameserver = nil) then TryToLoadFile(edtFilename.Text);
  if (frameserver <> nil) then begin
    edtFirstFrame.Text := '0';
    edtLastFrame.Text := IntToStr(frameserver.getNumImages() - 1);
  end;
end;

procedure TForm1.StatusBar1Resize(Sender: TObject);
var
  w, i: integer;
begin
  // make panel 0 stretch to fit
  w := StatusBar1.Width;
  for i := 1 to StatusBar1.Panels.Count-1 do
    w := w - StatusBar1.Panels[i].Width;

  StatusBar1.Panels[0].Width := w;
end;

procedure TForm1.UpdateStatusBar(currFrame, w, h, max:integer);
begin
  StatusBar1.Panels[2].Text := 'Frame ' + IntToStr(currFrame);
  StatusBar1.Panels[3].Text := IntToStr(w) + ' x ' + IntToStr(h) + ' pixels';
  StatusBar1.Panels[4].Text := IntToStr(w*h*4 div (1024*1024)) + ' MB';
  StatusBar1.Panels[5].Text := 'Max ' + IntToStr(max) + 'px';
end;

procedure TForm1.tmrStatsTimer(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := IntToStr(numFramesInLastInterval) + ' fps';
  numFramesInLastInterval := 0;
end;

procedure TForm1.imgvwStitchMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer; Layer: TCustomLayer);
begin
  if (ssLeft in Shift) then begin
    imgvwStitch.Scroll(dragStartX-X,dragStartY-Y);
    dragStartX := X;
    dragStartY := Y;
  end;
end;

procedure TForm1.imgvwStitchMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if (ssLeft in Shift) then begin
    dragStartX := X;
    dragStartY := Y;
  end;
end;

procedure TForm1.btnResetCropClick(Sender: TObject);
begin
  if (frameserver = nil) then TryToLoadFile(edtFilename.Text);
  if (frameserver <> nil) then begin
    edtCropLeft.Text := '0';
    edtCropTop.Text := '0';
    edtCropWidth.Text := IntToStr(frameserver.getWidth());
    edtCropHeight.Text := IntToStr(frameserver.getHeight());
  end;
end;

procedure TForm1.edtBGFillChange(Sender: TObject);
var
  i: integer;
begin
  i:=strtointdef('$'+edtBGFill.Text, -1);
  if (Length(edtBGFill.Text)<>6) or (i = -1)
  then begin
    shBGFill.Pen.Color:=clRed;
    shBGFill.Brush.Color:=clNone;
  end else begin
    shBGFill.Pen.Color:=clBlack;
    blankcolour:=i;
    shBGFill.Brush.Color:=WinColor(i);
  end;
end;

end.
