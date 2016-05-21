function varargout = Interfaz(varargin)
% INTERFAZ MATLAB code for Interfaz.fig
%      INTERFAZ, by itself, creates a new INTERFAZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ returns the handle to a new INTERFAZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ.M with the given input arguments.
%
%      INTERFAZ('Property','Value',...) creates a new INTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interfaz

% Last Modified by GUIDE v2.5 20-May-2016 03:07:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfaz_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Interfaz is made visible.
function Interfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interfaz (see VARARGIN)

% Choose default command line output for Interfaz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interfaz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in c_mundo.
function c_mundo_Callback(hObject, eventdata, handles)
global control1 mundo

% Cargar Mundo
mundo=vrworld('helicopterom.wrl');
open(mundo);
fig = vr.canvas(mundo, gcf, [14 104 977 436]);

% Abrir Nodos
elices=vrnode(mundo,'elices'); %Elices
elices2=vrnode(mundo,'elice_t1'); % Elice trasera

% Funcion Encender Helicoptero
control1 = get(handles.r_e,'Value')

while control1 == 1
    for i=1:.1:50
        elices.rotation=[0 1 0 i];
        elices2.rotation=[0 0 1 i];
        pause(0.01);
    end
end

% Funciones de camaras
cam_atras = get(handles.r_atras,'Value');
if cam_atras == 1
    set (fig,'Viewpoint','VP1');
end
cam_frente = get(handles.r_frente,'Value');
if cam_frente == 1
    set (fig,'Viewpoint','VP3');
end
cam_izquierda = get(handles.r_izquierda,'Value');
if cam_izquierda == 1
    set (fig,'Viewpoint','VP2');
end
cam_derecha = get(handles.r_derecha,'Value');
if cam_derecha == 1
    set (fig,'Viewpoint','VP4');
end
cam_arriba = get(handles.r_arriba,'Value'); 
if cam_arriba == 1
    set (fig,'Viewpoint','VP5');
end
cam_abajo = get(handles.r_abajo,'Value');
if cam_abajo == 1
    set (fig,'Viewpoint','VP6');
end

% hObject    handle to c_mundo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in c_simular.
function c_simular_Callback(hObject, eventdata, handles)
global mundo_2 val
% Cargar Mundo
mundo_2=vrworld('helicopterom.wrl');
open(mundo_2);
fig = vr.canvas(mundo_2, gcf, [14 104 977 436]);

% Abrir Nodos
helicoptero=vrnode(mundo_2,'helicoptero'); % Helicoptero
elices=vrnode(mundo_2,'elices'); %Elices
elices2=vrnode(mundo_2,'elice_t1'); % Elice trasera
val=1;
while val == 1
    set (fig,'Viewpoint','VP2');
%     % DOS GIROS 360°
    for i=1:.1:12.5
    helicoptero.rotation=[1 0 0 0.1];
    helicoptero.rotation=[0 1 0 i];
    pause(0.01)
    end
%    % ELEVA
    for i=1:.1:30
    helicoptero.translation=[0 i 0];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001)
    end
%    % Neutro hacia Adelante
    for i=1:.1:30
    if i < 1.3
        x=i-1;
        helicoptero.rotation=[1 0 0 -x];
        pause(0.000001);
    end
    helicoptero.translation=[0 30 -i];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001);
    end
%     % Delante hacia Atras
    for i=1:.1:60
        if i < 1.3
        z=i-1;
        helicoptero.rotation=[1 0 0 z];
        pause(0.000001)
        end
    a=30-i;
    helicoptero.translation=[0 30 -a];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001)
    end
%     % De Atras hacia Neutro
    for i=1:.1:30
   if i < 1.3
        x2=i-1;
        helicoptero.rotation=[1 0 0 -x2];
        pause(0.000001)
   end
    an=a+i;
    helicoptero.translation=[0 30 -an];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001)
    end
    % DESCIENDE
    for i=1:.1:30
   if i < 1.3
        helicoptero.rotation=[1 0 0 0.1];
        pause(0.000001)
    end
    helicoptero.translation=[0 30-i 0];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001);
    end
     % EFECTO IZQUIERDA-DERECHA
    set (fig,'Viewpoint','VP3'); 
%    % ELEVA
    for i=1:.1:30
    helicoptero.translation=[0 i 0];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    alt=i;
    pause(0.00001)
    end
%    % IZQ
    for i=1:.1:30
        m=i-1;
        if m < .3
         helicoptero.rotation=[0 0 1 -0.2];  
         pause(0.1)
        end
    helicoptero.translation=[i alt 0];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001)
    izq=i;
    end
%    %DER
    for i=1:.1:60
    der=izq-i;
    y=i-1;
        if y < .3
         helicoptero.rotation=[0 0 1 0.2];  
        end
    helicoptero.translation=[der alt 0];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001)
    end
%    %PUNTO NEUTRO
    for i=1:.1:30
    z=i-1;
        if z < 0.3
         helicoptero.rotation=[0 0 1 -0.4];  
        end
    neu=der+i;
    helicoptero.translation=[neu alt 0];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001)
    end
   for i=.0:.0
         helicoptero.rotation=[0 0 1 i];  
         pause(0.1)
   end
%     % DESCIENDE
    for i=1:.1:30
        if i < 1.3
        helicoptero.rotation=[1 0 0 0.1];
        pause(0.000001)
        end
    helicoptero.translation=[0 30-i 0];
    elices.rotation=[0 1 0 i];
    elices2.rotation=[0 0 1 i];
    pause(0.00001);
    end
    val=0;
end
% hObject    handle to c_simular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
clear all
close all
clc
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in c_manejar.
function c_manejar_Callback(hObject, eventdata, handles)
global mundo_3 val
% ESTABLECER COMUNICACION CON ARDUINO
delete(instrfind({'Port'},{'COM3'}));
puerto_serial=serial('COM3');
puerto_serial.BaudRate=9600;
fopen(puerto_serial);
val=1;  %CICLO
elevar=0; %ELEVAR - DESCENDER
adelante=0; % ADELANTE - ATRAS
izqder=0; % IZQ-DER
h=0; % Eices time
% ABRIR MUNDO 
mundo_3=vrworld('helicopterom.wrl');
open(mundo_3);
fig = vr.canvas(mundo_3, gcf, [14 104 977 436]);
% NODOS DEL MUNDO
helicoptero=vrnode(mundo_3,'helicoptero'); % Helicoptero
elices=vrnode(mundo_3,'elices'); %Elices
elices2=vrnode(mundo_3,'elice_t1'); % Elice trasera
valor=fscanf(puerto_serial,'%s');

if valor == 'O'
    cam_abajo = get(handles.r_abajo,'Value');
    cam_abajo =1;
end

while val == 1
    h=h+0.1;
    elices.rotation=[0 1 0 h];
    elices2.rotation=[0 0 1 h];
set (fig,'Viewpoint','VP3'); 
valor=fscanf(puerto_serial,'%s')

if elevar >= 0
if valor == 'E'
    elevar = elevar+1;
    helicoptero.translation=[izqder elevar adelante];
    helicoptero.rotation=[1 0 0 0.1];
end
if valor == 'S'
    elevar=elevar-1;
    helicoptero.translation=[izqder elevar adelante];
    helicoptero.rotation=[1 0 0 0.1];
end
else
    elevar=0.1
end

if valor == 'A'
    adelante=adelante-1;
    helicoptero.translation=[izqder elevar adelante];
    helicoptero.rotation=[1 0 0 -0.3];
end
if valor == 'T'
    adelante=adelante+1;
    helicoptero.translation=[izqder elevar adelante];
    helicoptero.rotation=[1 0 0 0.3];
end

if valor == 'I'
    izqder=izqder+1;
    helicoptero.translation=[izqder elevar adelante];
    helicoptero.rotation=[0 0 1 -0.2]; 
end
if valor == 'D'
    izqder=izqder-1;
    helicoptero.translation=[izqder elevar adelante];
    helicoptero.rotation=[0 0 1 0.2]; 
end

end
% hObject    handle to c_manejar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global val
val=2;
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



