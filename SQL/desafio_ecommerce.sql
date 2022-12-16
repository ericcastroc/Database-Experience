-- criação do banco de dados para o cenário de E-Commerce


create database ecommerce;
use ecommerce;


-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Frame varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Adress varchar(30),
        constraint unique_cpf_client unique (CPF)
);


-- criar tabela produto
-- size = dimensão do produto


create table product(
		IdProduct int auto_increment primary key,
        Pname varchar(10),
        classification_kits bool,
        category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'),
        avaliação float default 0,
        size varchar(10),
        constraint unique_cpf_client unique (CPF)
);        


-- criar tabela pedido(

create table orders(
		IdOrder int auto_increment primary key,
        IdOrderClient int,
        orderStatus enum('Cancelado','Confirmado','Em Processamento') default 'Em Processamento',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentstatus enum('Aprovado','Não Autorizado','Aguardando Pagamento') default 'Aguardando Pagamento',
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient),
        constraint fk_payment foreign key (paymentstatus) references payments(id_payment)
);


-- criar tabela de pagamentos


create table payments(
		idClient int,
        id_payment int,
        typePayment enum('Boleto','Cartão','Dois Cartões'),
        limitAvaliable float,
        constraint pk_payment primary key(idClient, id_payment)
);


-- criar tabela estoque


create table productstorage(
		IdProductStorage int auto_increment primary key,
        StorageLocation varchar(255),
        quantity int default 0
);        


-- criar tabela fornecedor


create table supplier(
		IdSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
	    constraint unique_supplier unique (CNPJ)
);        


-- criar tabela vendedor


create table seller(
		IdSeller int auto_increment primary key,
        SocialName varchar(255),
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        location varchar (255),
        contact char(11) not null,
        constraint unique_cpf_seller unique (CPF),
        constraint unique_cnpj_seller unique (CNPJ)
);        

create table productSeller(
		idPseller int,
        idProduct int,
        prodQuantity int default 1,
        primary key (idPseler, idProduct),
        constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
        constraint fk_product_product foreign key (idProduct) references product(idProduct)
);


show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';