function varargout = guide_teste(varargin)
% GUIDE_TESTE M-file for guide_teste.fig
%      GUIDE_TESTE, by itself, creates a new GUIDE_TESTE or raises the existing
%      singleton*.
%
%      H = GUIDE_TESTE returns the handle to a new GUIDE_TESTE or the handle to
%      the existing singleton*.
%
%      GUIDE_TESTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_TESTE.M with the given input arguments.
%
%      GUIDE_TESTE('Property','Value',...) creates a new GUIDE_TESTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guide_teste_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guide_teste_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guide_teste

% Last Modified by GUIDE v2.5 20-Nov-2007 12:18:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_teste_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_teste_OutputFcn, ...
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


% --- Executes just before guide_teste is made visible.
function guide_teste_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guide_teste (see VARARGIN)

% Choose default command line output for guide_teste
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guide_teste wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guide_teste_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[name,path]=uigetfile('*.xls');
fullpath = [path,name];

rede=load('rede\teste6_2.mat');

dados=xlsread(fullpath);

dados_entrada=getDados_entrada(dados);
dados_entrada_norm = normalizaEntrada(dados_entrada);

dados_target = getDados_target(dados);

resultados=sim(rede.net,dados_entrada_norm);

total_dados=size(dados_target,2);
[bem_total,PV,PF,NV,NF,sensitivity,specificity]= avaliador(resultados, dados_target);




set(handles.text6,'String',num2str(bem_total));
set(handles.text8,'String',num2str(total_dados));
set(handles.text10,'String',[num2str((bem_total/total_dados)*100),' %']);
set(handles.text14,'String',[num2str(specificity*100),' %']);
set(handles.text16,'String',[num2str(sensitivity*100),' %']);
set(handles.text21,'String',num2str(PV));
set(handles.text22,'String',num2str(PF));
set(handles.text23,'String',num2str(NV));
set(handles.text24,'String',num2str(NF));

