unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    BtFloyd_Steinberg: TButton;
    btAleatoire: TButton;
    BtMatriciel22: TButton;
    BtMatriciel33: TButton;
    BtMatriciel44: TButton;
    BtOriginal: TButton;
    Btseuil40: TButton;
    TrackSeuil: TTrackBar;
    Label1: TLabel;
    BtFloyd_SteinbergMatrice: TButton;
    Button2: TButton;
    BtFloyd_SteinbergAleatoire: TButton;
    procedure BtFloyd_SteinbergClick(Sender: TObject);
    procedure btAleatoireClick(Sender: TObject);
    procedure BtMatriciel22Click(Sender: TObject);
    procedure BtMatriciel33Click(Sender: TObject);
    procedure BtMatriciel44Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtOriginalClick(Sender: TObject);
    procedure BtseuilClick(Sender: TObject);
    procedure TrackSeuilChange(Sender: TObject);
    procedure BtFloyd_SteinbergMatriceClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BtFloyd_SteinbergAleatoireClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  bt: TBitmap;

const
 seuil22:array[0..3] of integer = (32,160,222,96);
 seuil33:array[0..8] of integer = (198,255,141,56,28,113,170,85,226);
 seuil44:array[0..15] of integer = (15,143,47,175,207,79,239,111,63,191,31,159,255,127,223,95);

implementation

{$R *.dfm}

// algo de Floyd-Steinberg
procedure TForm1.BtFloyd_SteinbergClick(Sender: TObject);
var
 rw,w,h,i,j,k,l:integer;
 gc,g:integer;
 p:pbytearray;
 tab:array of integer;
begin
 image1.Picture.Bitmap.Assign(bt);
 w:=image1.Picture.Bitmap.Width;
 h:=image1.Picture.Bitmap.Height;
 rw := (((w * 32) + 31) and not 31) div 8;

 p:=image1.Picture.Bitmap.ScanLine[h-1];
 w:=w+1; h:=h+1; setlength(tab,w*h);

 //passe l'image en niveau de gris et sauve le tout dans tab
 for j:=0 to h-1 do
 for i:=0 to w-1 do
 if (i=w-1) or (j=h-1) then tab[i+w*j]:=0
 else
 begin
  k:=i*4+j*rw;
  // 30% de rouge, 59% de vert, 11% de bleu
  l:=(76*p[k+2]+151*p[k+1]+29*p[k+0]) div 256;
  tab[i+w*j] :=l;
 end;

 // effectue l'algo de Floyd-Steinberg dans tab
 for j:=0 to h-2 do
 for i:=0 to w-2 do
  begin
   k:=i+j*w;
   gc:=tab[k];
   if gc<128 then g:=0 else g:=255;
   gc:=gc-g;
   tab[k]:=g;
   tab[k+1]:=tab[k+1]+gc*7 div 16;
   tab[k-1+w]:=tab[k-1+w]+gc*3 div 16;
   tab[k+0+w]:=tab[k+0+w]+gc*5 div 16;
   tab[k+1+w]:=tab[k+1+w]+gc*1 div 16;
  end;

 // transfert tab dans le bitmap
 for j:=0 to h-2 do
 for i:=0 to w-2 do
  begin
   k:=i*4+j*rw;
   p[k+2]:=tab[i+w*j];
   p[k+1]:=tab[i+w*j];
   p[k+0]:=tab[i+w*j];
  end;
end;

// algo Aléatoire
procedure TForm1.btAleatoireClick(Sender: TObject);
var
 rw,i,j,k,l:integer;
 p:pbytearray;
begin
 image1.Picture.Bitmap.Assign(bt);
 rw := (((bt.Width * 32) + 31) and not 31) div 8;
 p:=image1.Picture.Bitmap.ScanLine[bt.Height-1];
 for j:=0 to bt.Height-1 do
 for i:=0 to bt.Width-1 do
 begin
  k:=i*4+j*rw;
  // passe en niveau de gris
  l:=(76*p[k+2]+150*p[k+1]+30*p[k+0]) div 256;
  //  on tire au hasard entre 0 et 255 et on compare avec la couleur
  if l<random(256) then l:=0 else l:=255;
  // on met à jour le bitmap
  p[k+2]:=l;
  p[k+1]:=l;
  p[k+0]:=l;
 end;
end;

// algo matrice de 2x2
procedure TForm1.BtMatriciel22Click(Sender: TObject);
var
 rw,i,j,k,l,m:integer;
 p:pbytearray;
begin
 image1.Picture.Bitmap.Assign(bt);
 rw := (((bt.Width * 32) + 31) and not 31) div 8;
 p:=image1.Picture.Bitmap.ScanLine[bt.Height-1];
 for j:=0 to bt.Height-1 do
 for i:=0 to bt.Width-1 do
 begin
  k:=i*4+j*rw;
  // passe en niveau de gris
  l:=(76*p[k+2]+150*p[k+1]+30*p[k+0]) div 256;
  // calcul la case de la matrice associée au pixel (i,j)
  m:=(i mod 2)+(j mod 2)*2;
  // suivant le seuil
  if l<seuil22[m] then l:=0 else l:=255;
  // on met à jour le bitmap
  p[k+2]:=l;
  p[k+1]:=l;
  p[k+0]:=l;
 end;
end;

// algo matrice de 3x3
procedure TForm1.BtMatriciel33Click(Sender: TObject);
var
 rw,i,j,k,l,m:integer;
 p:pbytearray;
begin
 image1.Picture.Bitmap.Assign(bt);
 rw := (((bt.Width * 32) + 31) and not 31) div 8;
 p:=image1.Picture.Bitmap.ScanLine[bt.Height-1];
 for j:=0 to bt.Height-1 do
 for i:=0 to bt.Width-1 do
 begin
  k:=i*4+j*rw;
  // passe en niveau de gris
  l:=(76*p[k+2]+150*p[k+1]+30*p[k+0]) div 256;
  // calcul la case de la matrice associée au pixel (i,j)
  m:=(i mod 3)+(j mod 3)*3;
  // suivant le seuil
  if l<seuil33[m] then l:=0 else l:=255;
  // on met à jour le bitmap
  p[k+2]:=l;
  p[k+1]:=l;
  p[k+0]:=l;
 end;
end;

// algo matrice de 4x4
procedure TForm1.BtMatriciel44Click(Sender: TObject);
var
 rw,i,j,k,l,m:integer;
 p:pbytearray;
begin
image1.Picture.Bitmap.Assign(bt);
 rw := (((bt.Width * 32) + 31) and not 31) div 8;
 p:=image1.Picture.Bitmap.ScanLine[bt.Height-1];
 for j:=0 to bt.Height-1 do
 for i:=0 to bt.Width-1 do
 begin
  k:=i*4+j*rw;
  // passe en niveau de gris
  l:=(76*p[k+2]+150*p[k+1]+30*p[k+0]) div 256;
  // calcul la case de la matrice associée au pixel (i,j)
  m:=(i mod 4)+(j mod 4)*4;
  // suivant le seuil
  if l<seuil44[m] then l:=0 else l:=255;
  // on met à jour le bitmap
  p[k+2]:=l;
  p[k+1]:=l;
  p[k+0]:=l;
 end;
end;

// algo simple du seuil
procedure TForm1.BtseuilClick(Sender: TObject);
var
 rw,i,j,k,l:integer;
 seuil:integer;
 p:pbytearray;
begin
 seuil:=TrackSeuil.Position;
 image1.Picture.Bitmap.Assign(bt);
 rw := (((bt.Width * 32) + 31) and not 31) div 8;
 p:=image1.Picture.Bitmap.ScanLine[bt.Height-1];
 for j:=0 to bt.Height-1 do
 for i:=0 to bt.Width-1 do
 begin
  k:=i*4+j*rw;
  // passe en niveau de gris
  l:=(76*p[k+2]+150*p[k+1]+30*p[k+0]) div 256;
  //suivant le seuil choisi, c'est noir ou blanc
  if l<seuil then l:=0 else l:=255;
  // on met à jour le bitmap
  p[k+2]:=l;
  p[k+1]:=l;
  p[k+0]:=l;
 end;
end;

procedure TForm1.TrackSeuilChange(Sender: TObject);
begin
 label1.Caption:='Threshold: '+inttostr(TrackSeuil.Position*100 div 256)+'%';
 BtseuilClick(nil);
end;

procedure TForm1.BtFloyd_SteinbergMatriceClick(Sender: TObject);
var
 rw,w,h,i,j,k,l,m:integer;
 gc,g:integer;
 p:pbytearray;
 tab:array of integer;
begin
 image1.Picture.Bitmap.Assign(bt);
 w:=image1.Picture.Bitmap.Width;
 h:=image1.Picture.Bitmap.Height;
 rw := (((w * 32) + 31) and not 31) div 8;

 p:=image1.Picture.Bitmap.ScanLine[h-1];
 w:=w+1; h:=h+1; setlength(tab,w*h);

 //passe l'image en niveau de gris et sauve le tout dans tab
 for j:=0 to h-1 do
 for i:=0 to w-1 do
 if (i=w-1) or (j=h-1) then tab[i+w*j]:=0
 else
 begin
  k:=i*4+j*rw;
  // 30% de rouge, 59% de vert, 11% de bleu
  l:=(76*p[k+2]+151*p[k+1]+29*p[k+0]) div 256;
  tab[i+w*j] :=l;
 end;

 // effectue l'algo de Floyd-Steinberg dans tab
 for j:=0 to h-2 do
 for i:=0 to w-2 do
  begin
   k:=i+j*w;
   gc:=tab[k];
   m:=(i mod 4)+(j mod 4)*4;
   // suivant le seuil
   if gc<seuil44[m] then g:=0 else g:=255;
   gc:=gc-g;
   tab[k]:=g;
   tab[k+1]:=tab[k+1]+gc*7 div 16;
   tab[k-1+w]:=tab[k-1+w]+gc*3 div 16;
   tab[k+0+w]:=tab[k+0+w]+gc*5 div 16;
   tab[k+1+w]:=tab[k+1+w]+gc*1 div 16;
  end;

 // transfert tab dans le bitmap
 for j:=0 to h-2 do
 for i:=0 to w-2 do
  begin
   k:=i*4+j*rw;
   p[k+2]:=tab[i+w*j];
   p[k+1]:=tab[i+w*j];
   p[k+0]:=tab[i+w*j];
  end;
end;

procedure TForm1.BtFloyd_SteinbergAleatoireClick(Sender: TObject);
var
 rw,w,h,i,j,k,l:integer;
 gc,g:integer;
 p:pbytearray;
 tab:array of integer;
begin
 image1.Picture.Bitmap.Assign(bt);
 w:=image1.Picture.Bitmap.Width;
 h:=image1.Picture.Bitmap.Height;
 rw := (((w * 32) + 31) and not 31) div 8;

 p:=image1.Picture.Bitmap.ScanLine[h-1];
 w:=w+1; h:=h+1; setlength(tab,w*h);

 //passe l'image en niveau de gris et sauve le tout dans tab
 for j:=0 to h-1 do
 for i:=0 to w-1 do
 if (i=w-1) or (j=h-1) then tab[i+w*j]:=0
 else
 begin
  k:=i*4+j*rw;
  // 30% de rouge, 59% de vert, 11% de bleu
  l:=(76*p[k+2]+151*p[k+1]+29*p[k+0]) div 256;
  tab[i+w*j] :=l;
 end;

 // effectue l'algo de Floyd-Steinberg dans tab
 for j:=0 to h-2 do
 for i:=0 to w-2 do
  begin
   k:=i+j*w;
   gc:=tab[k];
   // suivant le seuil
   if gc<random(256) then g:=0 else g:=255;
   gc:=gc-g;
   tab[k]:=g;
   tab[k+1]:=tab[k+1]+gc*7 div 16;
   tab[k-1+w]:=tab[k-1+w]+gc*3 div 16;
   tab[k+0+w]:=tab[k+0+w]+gc*5 div 16;
   tab[k+1+w]:=tab[k+1+w]+gc*1 div 16;
  end;

 // transfert tab dans le bitmap
 for j:=0 to h-2 do
 for i:=0 to w-2 do
  begin
   k:=i*4+j*rw;
   p[k+2]:=tab[i+w*j];
   p[k+1]:=tab[i+w*j];
   p[k+0]:=tab[i+w*j];
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Image1.Parent.DoubleBuffered:=true;
 Image1.Picture.LoadFromFile('image.bmp');
 bt:=tbitmap.Create;
 bt.Assign(image1.Picture.Bitmap);
 bt.PixelFormat:=pf32bit;
end;

procedure TForm1.BtOriginalClick(Sender: TObject);
begin
 image1.Picture.Bitmap.Assign(bt);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Close;
end;

end.

