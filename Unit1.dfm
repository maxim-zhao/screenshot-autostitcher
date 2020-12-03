object Form1: TForm1
  Left = 224
  Top = 104
  Width = 526
  Height = 430
  Caption = 'Screenshot Autostitcher 0.8'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControls: TPanel
    Left = 0
    Top = 0
    Width = 518
    Height = 201
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      518
      201)
    object btnSave: TButton
      Left = 432
      Top = 140
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Save'
      TabOrder = 3
      OnClick = btnSaveClick
    end
    object btnCopy: TButton
      Left = 432
      Top = 166
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Copy'
      TabOrder = 4
      OnClick = btnCopyClick
    end
    object btnAutoStitch32: TButton
      Left = 432
      Top = 114
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Autostitch'
      TabOrder = 2
      OnClick = btnAutoStitch32Click
    end
    object cbFollowStitch: TCheckBox
      Left = 424
      Top = 32
      Width = 80
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Follo&w stitch'
      TabOrder = 1
    end
    object PageControl: TPageControl
      Left = 8
      Top = 8
      Width = 409
      Height = 185
      ActivePage = tsSettings
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      object tsInputs: TTabSheet
        Caption = 'Inputs'
        DesignSize = (
          401
          157)
        object lblFilename: TLabel
          Left = 8
          Top = 11
          Width = 42
          Height = 13
          Caption = '&Filename'
          FocusControl = edtFilename
        end
        object lblFirstFrame: TLabel
          Left = 8
          Top = 108
          Width = 35
          Height = 13
          Caption = 'F&rames'
          FocusControl = edtFirstFrame
        end
        object lblToFrame: TLabel
          Left = 170
          Top = 108
          Width = 10
          Height = 13
          Caption = 't&o'
          FocusControl = edtLastFrame
        end
        object lblDecimate: TLabel
          Left = 8
          Top = 131
          Width = 59
          Height = 13
          Caption = '&Decimate by'
          FocusControl = edtDecimateFrameRate
        end
        object lblCropTop: TLabel
          Left = 56
          Top = 60
          Width = 28
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Top'
          FocusControl = edtCropTop
        end
        object lblCropLeft: TLabel
          Left = 152
          Top = 60
          Width = 28
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Left'
          FocusControl = edtCropLeft
        end
        object lblCropWidth: TLabel
          Left = 40
          Top = 84
          Width = 44
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'W&idth'
          FocusControl = edtCropWidth
        end
        object lblCropHeight: TLabel
          Left = 148
          Top = 84
          Width = 32
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Height'
          FocusControl = edtCropHeight
        end
        object edtFilename: TEdit
          Left = 88
          Top = 8
          Width = 273
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'D:\My Documents\SMS\Gens\mm2-000001.bmp'
        end
        object btnBrowseFilename: TButton
          Left = 368
          Top = 8
          Width = 25
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 1
          OnClick = btnBrowseFilenameClick
        end
        object cbUseMask: TCheckBox
          Left = 8
          Top = 34
          Width = 73
          Height = 17
          Caption = '&Mask'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object edtMask: TEdit
          Left = 88
          Top = 32
          Width = 273
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          Text = 'D:\My Documents\SMS\Gens\mask.bmp'
        end
        object btnBrowseMask: TButton
          Left = 368
          Top = 32
          Width = 25
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 4
          OnClick = btnBrowseMaskClick
        end
        object edtFirstFrame: TEdit
          Left = 88
          Top = 104
          Width = 49
          Height = 21
          TabOrder = 12
        end
        object edtLastFrame: TEdit
          Left = 184
          Top = 104
          Width = 49
          Height = 21
          TabOrder = 13
        end
        object btnAllFrames: TButton
          Left = 240
          Top = 104
          Width = 57
          Height = 21
          Caption = 'Reset'
          TabOrder = 14
          OnClick = btnAllFramesClick
        end
        object cbReverseOrder: TCheckBox
          Left = 184
          Top = 130
          Width = 89
          Height = 17
          Caption = 'Re&verse order'
          TabOrder = 17
        end
        object edtDecimateFrameRate: TEdit
          Left = 88
          Top = 128
          Width = 49
          Height = 21
          TabOrder = 16
          Text = '1'
        end
        object cbCrop: TCheckBox
          Left = 8
          Top = 58
          Width = 49
          Height = 17
          Caption = 'Cro&p'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object edtCropTop: TEdit
          Left = 88
          Top = 56
          Width = 49
          Height = 21
          TabOrder = 6
        end
        object edtCropLeft: TEdit
          Left = 184
          Top = 56
          Width = 49
          Height = 21
          TabOrder = 7
        end
        object edtCropWidth: TEdit
          Left = 88
          Top = 80
          Width = 49
          Height = 21
          TabOrder = 8
        end
        object edtCropHeight: TEdit
          Left = 184
          Top = 80
          Width = 49
          Height = 21
          TabOrder = 9
        end
        object btnResetCrop: TButton
          Left = 240
          Top = 80
          Width = 57
          Height = 21
          Caption = 'Reset'
          TabOrder = 10
          OnClick = btnResetCropClick
        end
        object cbResetCropOnLoad: TCheckBox
          Left = 304
          Top = 81
          Width = 89
          Height = 17
          Caption = 'Reset on load'
          TabOrder = 11
        end
        object cbResetFramesOnLoad: TCheckBox
          Left = 304
          Top = 105
          Width = 89
          Height = 17
          Caption = 'Reset on load'
          TabOrder = 15
        end
      end
      object tsSettings: TTabSheet
        Caption = 'Stitch settings'
        ImageIndex = 1
        object lblSearchDistance: TLabel
          Left = 8
          Top = 11
          Width = 61
          Height = 13
          Caption = 'S&earch up to'
          FocusControl = edtPixelSearchDist
        end
        object lblBadMatch: TLabel
          Left = 8
          Top = 35
          Width = 70
          Height = 13
          Caption = '&Bad match if <'
          FocusControl = edtBadMatchThreshold
        end
        object lblGoodPercent: TLabel
          Left = 144
          Top = 36
          Width = 43
          Height = 13
          Caption = '% match'
        end
        object lblGoodMatch: TLabel
          Left = 8
          Top = 59
          Width = 77
          Height = 13
          Caption = '&Good match if >'
          FocusControl = edtGoodMatchThreshold
        end
        object lblBadPercent: TLabel
          Left = 144
          Top = 60
          Width = 43
          Height = 13
          Caption = '% match'
        end
        object lblScrolling: TLabel
          Left = 8
          Top = 83
          Width = 65
          Height = 13
          Caption = 'Scr&olling goes'
          FocusControl = cmbScrollingType
        end
        object lblSearchDistUnits: TLabel
          Left = 144
          Top = 12
          Width = 12
          Height = 13
          Caption = 'px'
        end
        object lblExpand: TLabel
          Left = 8
          Top = 107
          Width = 47
          Height = 13
          Caption = 'E&xpand in'
          FocusControl = edtExpand
        end
        object Label2: TLabel
          Left = 144
          Top = 108
          Width = 48
          Height = 13
          Caption = 'px chunks'
        end
        object Label1: TLabel
          Left = 200
          Top = 11
          Width = 69
          Height = 13
          Caption = 'Background &fill'
          FocusControl = edtBGFill
        end
        object shBGFill: TShape
          Left = 366
          Top = 8
          Width = 27
          Height = 20
        end
        object edtPixelSearchDist: TEdit
          Left = 88
          Top = 8
          Width = 49
          Height = 21
          TabOrder = 0
          Text = '16'
        end
        object edtBadMatchThreshold: TEdit
          Left = 88
          Top = 32
          Width = 49
          Height = 21
          TabOrder = 1
          Text = '50'
        end
        object edtGoodMatchThreshold: TEdit
          Left = 88
          Top = 56
          Width = 49
          Height = 21
          TabOrder = 2
          Text = '94'
        end
        object cmbScrollingType: TComboBox
          Left = 88
          Top = 80
          Width = 105
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 3
          Text = 'Both ways'
          Items.Strings = (
            'Both ways'
            'Horizontally'
            'Vertically')
        end
        object cbDrop00: TCheckBox
          Left = 8
          Top = 128
          Width = 121
          Height = 17
          Caption = '&Drop 0,0 matches'
          TabOrder = 5
        end
        object edtExpand: TEdit
          Left = 88
          Top = 104
          Width = 49
          Height = 21
          TabOrder = 4
          Text = '128'
        end
        object edtBGFill: TEdit
          Left = 280
          Top = 8
          Width = 81
          Height = 21
          TabOrder = 6
          OnChange = edtBGFillChange
        end
      end
      object tsGraph: TTabSheet
        BorderWidth = 4
        Caption = 'Graph'
        ImageIndex = 2
        object imgGraph: TImage
          Left = 0
          Top = 0
          Width = 393
          Height = 149
          Hint = '...'
          Align = alClient
          ParentShowHint = False
          ShowHint = False
        end
      end
      object tsLog: TTabSheet
        BorderWidth = 2
        Caption = 'Log'
        ImageIndex = 3
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 397
          Height = 153
          Align = alClient
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
      end
    end
  end
  object imgvwStitch: TImgView32
    Left = 0
    Top = 201
    Width = 518
    Height = 183
    Align = alClient
    Bitmap.DrawMode = dmBlend
    Bitmap.OuterColor = 2130706432
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baCustom
    Centered = False
    RepaintMode = rmOptimizer
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ScrollBars.ShowHandleGrip = False
    ScrollBars.Style = rbsDefault
    SizeGrip = sgNone
    OverSize = 512
    TabOrder = 1
    OnMouseDown = imgvwStitchMouseDown
    OnMouseMove = imgvwStitchMouseMove
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 384
    Width = 518
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Alignment = taRightJustify
        Text = 'fps'
        Width = 50
      end
      item
        Text = 'Frame'
        Width = 100
      end
      item
        Text = '0x0 pixels'
        Width = 120
      end
      item
        Alignment = taRightJustify
        Text = '0 MB'
        Width = 80
      end
      item
        Text = 'Max 0px'
        Width = 60
      end
      item
        Bevel = pbNone
        Width = 16
      end>
    OnResize = StatusBar1Resize
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'All supported types|*.bmp;*.png;*.gif;*.pcx;*.avi|Images (*.bmp;' +
      ' *.png; *.gif; *.pcx)|*.bmp;*.png;*.gif;*.pcx|Video (*.avi)|*.av' +
      'i|All files (*.*)|*.*'
    Title = 'Open one of the source images (dir+ext matter)'
    Left = 408
    Top = 320
  end
  object XPManifest1: TXPManifest
    Left = 440
    Top = 328
  end
  object SaveDialog1: TSaveDialog
    Filter = 'BMP (*.bmp)|*.bmp|All files (*.*)|*.*'
    Title = 'Save result'
    Left = 520
    Top = 304
  end
  object tmrStats: TTimer
    OnTimer = tmrStatsTimer
    Left = 480
    Top = 312
  end
end
