## Sūrya's Description Report

### Files Description Table


|  File Name  |  SHA-1 Hash  |
|-------------|--------------|
| ../dss/src/join.sol | c33c2652b17010c199cbe53c0acb1b28f0407bc4 |


### Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|     └      |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **GemLike** | Implementation |  |||
| └ | transfer | Public ❗️ | 🛑  |NO❗️ |
| └ | transferFrom | Public ❗️ | 🛑  |NO❗️ |
||||||
| **DSTokenLike** | Implementation |  |||
| └ | mint | Public ❗️ | 🛑  |NO❗️ |
| └ | burn | Public ❗️ | 🛑  |NO❗️ |
||||||
| **VatLike** | Implementation |  |||
| └ | slip | Public ❗️ | 🛑  |NO❗️ |
| └ | move | Public ❗️ | 🛑  |NO❗️ |
| └ | flux | Public ❗️ | 🛑  |NO❗️ |
||||||
| **GemJoin** | Implementation | DSNote |||
| └ | \<Constructor\> | Public ❗️ | 🛑  | |
| └ | join | Public ❗️ | 🛑  | note |
| └ | exit | Public ❗️ | 🛑  | note |
||||||
| **ETHJoin** | Implementation | DSNote |||
| └ | \<Constructor\> | Public ❗️ | 🛑  | |
| └ | join | Public ❗️ |  💵 | note |
| └ | exit | Public ❗️ | 🛑  | note |
||||||
| **DaiJoin** | Implementation | DSNote |||
| └ | \<Constructor\> | Public ❗️ | 🛑  | |
| └ | mul | Internal 🔒 |   | |
| └ | join | Public ❗️ | 🛑  | note |
| └ | exit | Public ❗️ | 🛑  | note |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
