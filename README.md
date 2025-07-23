# 📘 Exercício de Comandos DML – Sistema de Hotelaria

Este repositório é dedicado ao **aprendizado e prática de comandos SQL** utilizando um **banco de dados de um sistema de hotelaria**!  
Ideal para reforçar conhecimentos em SQL com foco em consultas, atualizações, inserções e exclusões de dados em múltiplas tabelas relacionadas.

---

## 🏨 Tema: Hotelaria
Imagine um sistema real de hotel que gerencia **hóspedes, reservas, quartos, pagamentos e serviços extras**. O objetivo é realizar comandos DML para extrair insights, manipular os dados de forma estratégica, e fazer uso de funções para as consultas.

---

## 💾 Estrutura do Banco de Dados

O banco contém as seguintes tabelas:

### 📄 `Hospede`
| Coluna         | Tipo          | Observações                     |
|----------------|---------------|---------------------------------|
| Id             | INT           | Chave Primária, Auto incremento |
| Nome           | VARCHAR(100)  | Obrigatório                     |
| CPF            | VARCHAR(14)   | Único                           |
| Email          | VARCHAR(100)  | -                               |
| DataNascimento | DATE          | -                               |

### 📄 `Reserva`
| Coluna       | Tipo | Observações                                |
|--------------|------|--------------------------------------------|
| Id           | INT  | Chave Primária, Auto incremento            |
| IdHospede    | INT  | Chave Estrangeira → `Hospede(Id)`          |
| DataCheckin  | DATE | -                                          |
| DataCheckout | DATE | -                                          |
| IdQuarto     | INT  | Chave Estrangeira → `Quarto(Id)`           |

### 📄 `Quarto`
| Coluna      | Tipo         | Observações                    |
|-------------|--------------|--------------------------------|
| Id          | INT          | Chave Primária, Auto incremento |
| Numero      | VARCHAR(10)  | Obrigatório                    |
| Tipo        | VARCHAR(50)  | Ex: "Simples", "Luxo", "Suíte" |
| PrecoDiaria | DECIMAL(7,2) | -                              |

### 📄 `Pagamento`
| Coluna         | Tipo         | Observações                           |
|----------------|--------------|---------------------------------------|
| Id             | INT          | Chave Primária, Auto incremento       |
| IdReserva      | INT          | Chave Estrangeira → `Reserva(Id)`     |
| DataPagamento  | DATE         | -                                     |
| Valor          | DECIMAL(8,2) | -                                     |
| FormaPagamento | VARCHAR(50)  | Ex: "Cartão", "Pix", "Dinheiro"       |

### 📄 `ServicoExtra`
| Coluna    | Tipo         | Observações                  |
|-----------|--------------|------------------------------|
| Id        | INT          | Chave Primária, Auto incremento |
| Descricao | VARCHAR(100) | -                            |
| Valor     | DECIMAL(7,2) | -                            |

### 📄 `ReservaServico`
| Coluna         | Tipo | Observações                                               |
|----------------|------|-----------------------------------------------------------|
| IdReserva      | INT  | Chave Primária / Estrangeira → `Reserva(Id)`              |
| IdServicoExtra | INT  | Chave Primária / Estrangeira → `ServicoExtra(Id)`         |

---

## 📝 Desafios SQL - Comandos DML
##### Atenção: Durante a criação das tabelas, observou-se a necessidade de criar mais 3 tabelas a parte, para telefone do hospede, Tipo do quarto e Forma de pagamento, por não serem atributos atômicos, o que é exigido na 1FN. 
### 💡 Utilize comandos `SELECT`, `UPDATE`, `DELETE`, `INSERT`, `JOIN`, `GROUP BY`, `HAVING`, entre outros, para resolver as questões abaixo:

1️⃣ Liste o nome dos hóspedes e a quantidade de reservas realizadas por cada um.  
2️⃣ Exiba os quartos que já foram reservados por mais de um hóspede diferente.  
3️⃣ Liste as reservas que não possuem nenhum pagamento registrado.  
4️⃣ Exiba o total pago por cada reserva, somando o valor do pagamento e dos serviços extras utilizados.  
5️⃣ Atualize a forma de pagamento da reserva do hóspede **"Fernanda Souza"** para **"Pix"**, considerando a reserva mais recente.  
6️⃣ Liste o nome dos hóspedes que já utilizaram três ou mais tipos diferentes de **serviços extras**.  
7️⃣ Remova todas as reservas com **check-out anterior a 01/01/2020**.  
8️⃣ Liste todos os serviços extras utilizados em reservas no **quarto número "202"**.  
9️⃣ Mostre os hóspedes que usaram o serviço **"Massagem Relaxante"** ao menos uma vez.  
🔟 Altere o tipo de todos os quartos com diária superior a **R$ 800,00** para **"Executivo"**.  
1️⃣1️⃣ Para cada quarto reservado, exiba: **número do quarto**, **tipo**, **nome do hóspede** e **data de check-in**.  
1️⃣2️⃣ Exiba os **5 hóspedes mais recentes** (com base na data da última reserva).  
1️⃣3️⃣ Mostre todos os pagamentos realizados, com: **nome do hóspede**, **número do quarto**, **valor pago** e **forma de pagamento**.  
1️⃣4️⃣ Exiba a **média de dias de estadia por tipo de quarto**.  
1️⃣5️⃣ Liste os hóspedes com e-mail **@gmail.com** que já realizaram **ao menos uma reserva**.

---

## 🧠 Objetivos de Aprendizado

✔️ Praticar comandos SQL reais em um banco de dados relacional  
✔️ Exercitar **consultas com múltiplas tabelas** usando `JOIN`  
✔️ Trabalhar com **filtros, agrupamentos e subconsultas**  
✔️ Realizar **manipulação de dados** com `UPDATE` e `DELETE`  
✔️ Simular operações típicas de um sistema de gestão de hotelaria

---

## 🚀 Como foi executado

1. Criei o banco de dados e as tabelas conforme a estrutura acima e repeitando as Normas 1FN, 2FN e 3FN.  
2. Populei com dados de teste.  
3. Utilizei o SQL Server Management Studio (SSMS).

---

## 📬 Contato

Desenvolvido por **Roberto Braga**  
📧 robertobdoliveira98@gmail.com
📌 Campina Grande – PB, Brasil

