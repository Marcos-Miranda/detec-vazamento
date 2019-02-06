clc;
clear all;

delete(instrfind({'Port'},{'COM3'})); %elimina qualquer atividade da porta serial
s = serial('COM3','BaudRate',115200); %configuraçao porta serial
set(s, 'terminator', 'LF'); % define o terminator paraprintln
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');

fopen(s); %abertura do porto serial

contador_errores=0; %Contador de erros ou valores não validos na porta serial
num_dados=101;




medicoes=0;

for a=1:num_dados;


for n=1:3; %espnum; %ciclo for dos grafico de espectros
    
contador_amostras=1; %Declaração do contador amostras
amostras=1560; %Declaração do numero de amostras

tic%Contador de tempo do ciclo while

while contador_amostras<= amostras; %ciclo de leitura de dados
    
a=fscanf(s,'%s',5); %variável de sincronizaçao

while ~strcmp(a,'Sync');
a=fscanf(s,'%s',5);
end

resto=fscanf(s,'%s',2);

eixoX = str2double(fscanf(s)); %valor da aceleraçao no eixo X no formato str
eixoY = str2double(fscanf(s)); %valor da aceleraçao no eixo Y no formato str
eixoZ = str2double(fscanf(s)); %valor da aceleraçao no eixo Z no formato str

if ~isnan(eixoX) && ~isnan(eixoY) && ~isnan(eixoZ); %ciclo if que garante o dado valido nos VetorXYZ
VX(contador_amostras)=eixoX;
VY(contador_amostras)=eixoY;
VZ(contador_amostras)=eixoZ;
contador_amostras=contador_amostras +1;
else
contador_errores=contador_errores+1;
end
% tempo(contador_amostras)=toc ;

end

tempo(n)=toc

X=VX'.*hann(amostras); %Aplicacao da janela Hanning
Y=VY'.*hann(amostras);
Z=VZ'.*hann(amostras);

%NFFT = amostras; % Calcula o número de linhas da FFT ao aproximar na potencia de 2 mais proxima
FFTX = fft(X)/amostras*2; % Calcula FFT de VetorX outra formula FFTX = fft(X,NFFT)/L*2;
FFTY = fft(Y)/amostras*2; % Calcula FFT de VetorY
FFTZ = fft(Z)/amostras*2; % Calcula FFT de VetorZ
f = amostras/2*linspace(0,1,amostras/2+1); %define a faixa de frequencia 0 até 1560 outra formula f = Fs/2*linspace(0,1,NFFT/2+1);

ESPX(n,:)=2*abs(FFTX(1:amostras/2+1))'; %calculo de espectros de frequencia
ESPY(n,:)=2*abs(FFTY(1:amostras/2+1))';
ESPZ(n,:)=2*abs(FFTZ(1:amostras/2+1))';

MediaESPX=mean(ESPX); %Calculo de medias dos espectros
MediaESPY=mean(ESPY);
MediaESPZ=mean(ESPZ);


end

if medicoes>0;
dados(1,medicoes)=median(MediaESPX);
dados(2,medicoes)=var(MediaESPX);
dados(3,medicoes)=std(MediaESPX);
dados(4,medicoes)=skewness(MediaESPX);
dados(5,medicoes)=kurtosis(MediaESPX);
dados(6,medicoes)=rms(MediaESPX);
dados(7,medicoes)=median(MediaESPY);
dados(8,medicoes)=var(MediaESPY);
dados(9,medicoes)=std(MediaESPY);
dados(10,medicoes)=skewness(MediaESPY);
dados(11,medicoes)=kurtosis(MediaESPY);
dados(12,medicoes)=rms(MediaESPY);
dados(13,medicoes)=median(MediaESPZ);
dados(14,medicoes)=var(MediaESPZ);
dados(15,medicoes)=std(MediaESPZ);
dados(16,medicoes)=skewness(MediaESPZ);
dados(17,medicoes)=kurtosis(MediaESPZ);
dados(18,medicoes)=rms(MediaESPZ);
end

medicoes = medicoes + 1;

end

fclose(s);

