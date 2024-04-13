--create database db_cria_peixe character set utf8mb4 collate utf8mb4_unicode_ci;

show databases;
use db_cria_peixe;
show tables;


select * from animaldecultivo;
insert into db_cria_peixe.animaldecultivo (idAnimal,nmAnimal) values 
(1, 'carpa'),
(2, 'tilápia');

select * from db_cria_peixe.tanque;
INSERT INTO db_cria_peixe.tanque (idTanque,nmTanque ) VALUES 
  (1, 'Caixa dágua'), 
  (2, 'Escavado');
  
select * from db_cria_peixe.unidadesmedida;
INSERT INTO db_cria_peixe.unidadesmedida ( idUnidadesMedida, nmUnidadesMedida, sgUnidadesMedida
 ) VALUES 
  (0, 'admensional', 'N/A'), 
  (1, 'metro', 'm' ),
  (2, 'metro quadrado', 'm^2' ),
  (3, 'quilograma', 'kg'),
  (4, 'miligrma por litro', 'mg/l')  
  ;