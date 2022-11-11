-- criação do banco de dados para o cenário de uma Oficina
create database workshop;
use workshop;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        clientName varchar(90) not null,
        CPF char(11) not null,
        cel varchar(11),
        constraint unique_cpf_client unique (CPF)        
);
-- criar tabela mecanicos;
create table mechanics(
		idMechanic int auto_increment primary key,
        mechanicName varchar(90),
		CPF char(11) not null,
        address varchar(45),
        specialization varchar(45),
        constraint unique_cpf_mechanic unique (CPF)        
);
-- criar tabela veículo;
create table automobile(
		idAutomobile int auto_increment primary key,
        idClient int not null,
        idMechanic int not null,
        constraint fk_automobile_client foreign key (idClient) references clients(idClient),
        constraint fk_automobile_mechanic foreign key (idMechanic) references mechanics(idMechanic)
);

-- criar tabela serviços;
create table services(
		idService int auto_increment primary key,
        idMechanic int not null,
        serviceDescription varchar(255),
        cost float,
        constraint fk_services_mechanic foreign key (idMechanic) references mechanics(idMechanic)
);
-- criar tabela ordem de serviço;
create table orders(
		idOrder int auto_increment primary key,
        idClient int,
		idPayment int,
        overview varchar(255),
        OrderStatus enum('Processando, Cancelado, Confirmado') default('Processando'),
        conclusionDate date,
        authorization tinyint,
        constraint fk_orders_client foreign key (idClient) references clients(idClient)
);

-- criar tabela peças, ;
create table parts(
		idPart int auto_increment primary key,
        partName int not null,
        partCost int not null
);

-- criar tabela de relação serviço, peça e ordem de serviço;
create table SO_part_service(
		idPart int not null,
        idOrder int not null,
        idService int not null,
        cost int not null,
        primary key (idPart, idOrder, idService),
		constraint fk_PartSO_idPart foreign key (idPart) references parts (idPart),
        constraint fk_PartSO_idOrder foreign key (idOrder) references orders (idOrder),
        constraint fk_PartSO_idService foreign key (idService) references services (idService)
);