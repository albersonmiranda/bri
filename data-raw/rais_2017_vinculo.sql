# ftp://ftp.mtps.gov.br/pdet/microdados/

CREATE SCHEMA IF NOT EXISTS bri;

USE bri;

DROP TABLE IF EXISTS rais2017_vinculo_se;

CREATE TABLE rais2017_vinculo_se (
b_sp char(4), # Bairros.Sp
b_fortaleza char(4), # Bairros.Fortaleza
b_rj char(4), # Bairros.RJ
ca1 char(2), # Causa.Afastamento.1
ca2 char(2), # Causa.Afastamento.2
ca3 char(2), # Causa.Afastamento.3
cd char(2), # Motivo.Desligamento
cbo char(6), # CBO.Ocupação.2002
cnae_classe char(5), # CNAE.2.0.Classe
cnae_95 char(5), # CNAE.95.Classe
d_sp char(4), # Distritos.SP
ind_ativo bit, # Vínculo.Ativo.31.12
faixa_etaria char(2), # Faixa.Etária
faixa_hora char(2), # Faixa.Hora.Contrat
faixa_rem_dez_sm char(2), # Faixa.Remun.Dezem..SM.
faixa_rem_media_sm char(2), # Faixa.Remun.Média..SM.
faixa_tempo_emprego char(2), # Faixa.Tempo.Emprego
escolaridade varchar(20), # Escolaridade.após.2005
carga_hora tinyint, # Qtd.Hora.Contr
idade tinyint, # Idade
ind_cei bit, # Ind.CEI.Vinculado
ind_simples bit, # Ind.Simples
mes_admissao char(2), # Mês.Admissão
mes_desligamento char(2), # Mês.Desligamento
muni_trab char(6), # Mun.Trab
muni_estab char(6), # Município
nacionalidade char(2), # Nacionalidade
nat_jur char(4), # Natureza.Jurídica
ind_pne bit, # Ind.Portador.Defic
dias_afastamento smallint, # Qtd.Dias.Afastamento
raca char(2), # Raça.Cor
b_df char(2), # Regiões.Adm.DF
rem_dez_n char(13), # Vl.Remun.Dezembro.Nom
rem_dez_sm char(13), # Vl.Remun.Dezembro..SM.
rem_media_n char(13), # Vl.Remun.Média.Nom
rem_media_sm char(13), # Vl.Remun.Média..SM.
cnae_subclasse char(7), # CNAE.2.0.Subclasse
sexo char(2), # Sexo.Trabalhador
tam_estab char(2), # Tamanho.Estabelecimento
tempo_emprego char(5), # Tempo.Emprego
tipo_admissao char(2), # Tipo.Admissão
tipo_estab char(2), # Tipo.Estab
tipo_estab2 char(4), # Tipo.Estab.1
tipo_pne char(2), # Tipo.Defic
tipo_vinculo char(2), # Tipo.Vínculo
ibge_subsetor char(2), # IBGE.Subsetor
rem_jan char(15), # Vl.Rem.Janeiro.CC
rem_fev char(15), # Vl.Rem.Fevereiro.CC
rem_mar char(15), # Vl.Rem.Março.CC
rem_abr char(15), # Vl.Rem.Abril.CC
rem_mai char(15), # Vl.Rem.Maio.CC
rem_jun char(15), # Vl.Rem.Junho.CC
rem_jul char(15), # Vl.Rem.Julho.CC
rem_ago char(15), # Vl.Rem.Agosto.CC
rem_set char(15), # Vl.Rem.Setembro.CC
rem_out char(15), # Vl.Rem.Outubro.CC
rem_nov char(15), # Vl.Rem.Novembro.CC
ano_arriv_br smallint, # Ano.Chegada.Brasil
ind_trab_parc bit, # Ind.Trab.Parcial
ind_trab_int bit # Ind.Trab.Intermitente
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rais/2017/vinculo/nordeste/SE2017.txt" INTO TABLE rais2017_vinculo_se
FIELDS TERMINATED BY ";"
ENCLOSED BY '"'
LINES TERMINATED BY "\r\n"
IGNORE 1 LINES
;

