<h1>Detecção de vazamento em sistemas de encanamento atráves de padrões de vibração</h1>

<p>Este projeto teve como inspiração outros existentes na área de detecção  de falhas em máquinas elétricas através 
de reconhecimento de padrões de vibração. O objetivo era descobrir se o mesmo princípio poderia ser utilizado com encanamentos, 
considerando que neste caso a diferença entre os padrões de vibração tenderiam a ser mais sútis do que no de máquinas, e então 
possibilitar a criação de um sistema de detecção de vazamento em tempo real.</p>

<p>Ele consiste de 3 áreas:</p>

<li>A maquete, que consistia de um pequeno circuito de canos em que passava água bombeada por uma bomba de aquário, e sendo o vazamento
simulado por uma válvula que desviava uma quantidade sútil de água de seu trajeto. O responsável por essa parte foi
<a href="https://github.com/notJader">Jader Felipe Moreira Santos</a>.</li>

<li>Aquisição  e processamento dos dados de vibração. Aqui foram utilizados um Arduino Mega 2560 e um acelerômetro MPU6050 para a medição
das vibrações nos 3 eixos. Em seguida esses dados eram transmitidos para o Matlab, no qual realizava-se o processamento digital, calculavam-se 
as variáveis estatíscas do espectro de frequência do sinal e por fim salvavam-se os dados em um arquivo CSV. 
<a href="https://github.com/ifertz">Fernando Augusto Neves</a> foi o responsável por essa área.</li>

<li>Treinamento do modelo de Machine Learning, área que coube a mim realizar. Essa parte consistiu em ler o arquivo CSV, realizar algum 
pré-processamento e treinar diferentes modelos utlizando diferentes algoritmos e diferentes atributos para comparação. Isso foi feito em 
Python com auxílio de módulos de Data Science/Machine Learning.</li>
</p>

<p>Neste repositório encontram-se o script do Matlab e código Python, que contém os resultados e considerações. O cógido utilizado no Arduino pertence a uma biblioteca criada por <a href="https://github.com/jrowberg/i2cdevlib/tree/master/Arduino/MPU6050">Jeff Rowberg</a>.</p>
