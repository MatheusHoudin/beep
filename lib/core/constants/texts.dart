const splashFirstText =
    'Agora você pode realizar inventários em suas empresa de forma ágil, diretamente na palma da sua mão, e o melhor, sem precisar de dispositivos caros.';
const splashSecondText =
    'Tenha em suas mãos relatórios sobre os seus inventários, em tempo real, realize análises e por fim, aumente a lucratividade do seu negócio e evite desperdícios.';
const splashThirdText =
    'Agora vamos realizar o cadastro de sua empresa, para que possamos incluir seus colaboradores e começe a criar inventários, para assim aproveitar nossa solução.';

// shared preferences
const userIdKey = 'userid';
const userNameKey = 'username';
const userEmailKey = 'useremail';
const userTypeKey = 'usertype';
const companyCodeKey = 'companycode';
// shared preferences

// errors
const genericErrorMessage = "Um erro inesperado ocorreu";
const genericErrorMessageTitle = "Ops...";
const genericErrorButton = "OK";
const noInternetConnectionError = "Sua conexão com a internet parece estar fraca, verifique e tente novamente";
// errors

// splash_page
const skip = 'PULAR';
const continueButton = 'AVANÇAR';
const back = 'VOLTAR';
// splash_page

// login_page
const emailFieldHint = 'Digite seu email de acesso';
const passwordFieldHint = 'Digite sua senha';
const login = 'ACESSAR MINHA CONTA';
const noAccount = 'Ainda não tem uma conta?';
const createAccount = 'CRIAR MINHA CONTA';
const wrongPassword = 'A senha fornecida não está correta, tente outra';
const userNotFound = 'Este usuário não existe, tente outro';
// login_page

// register_page
const registerPageAppBarTitle = 'CRIAR MINHA CONTA';
const registerPageNameFieldHint = 'Digite seu nome';
const registerPageEmailFieldHint = 'Digite seu email';
const registerPagePasswordFieldHint = 'Digite sua senha';
const registerPageRegisterButton = 'CRIAR MINHA CONTA';
const weakPassword = "Sua senha deve conter no mínimo 6 caracteres";
const emailAlreadyInUse = "Este email já está cadastrado, tente outro";
const invalidName = "O nome não pode ser vazio";
const invalidEmail = "O email fornecido não é um email válido";
const registerPageRegisterSuccessTitle = 'Sucesso!';
const registerPageRegisterSuccessMessage =
    'Sua conta foi criada com sucesso, utilize seu email e senha para fazer login';
// register_page

// home_company
const companyHi = 'Olá ';
const companyWelcome = ', seja bem vindo (a)';
const companyStart = 'Vamos começar?';
const companyCreateInventory = 'Criar novo Inventário';
const companyStartedInventoriesTitle = 'Iniciados';
const companyNotStartedInventoriesTitle = 'Próximos';
const companyFinishedInventoriesTitle = 'Finalizados';
// home_company

// create_inventory
const createInventoryToolbarTitle = 'CADASTRAR INVENTÁRIO';
const createInventoryInvalidName = 'O nome do inventário não deve ser vazio';
const createInventoryInvalidDescription = 'A descrição do inventário não deve ser vazia';
const createInventorySuccessTitle = 'Sucesso!';
const createInventorySuccessMessage = 'O inventário foi criado com sucesso';
const createInventoryNameHint = 'Digite o nome do inventário';
const createInventoryDateHint = 'Digite a data do inventário';
const createInventoryTimeHint = 'Digite o horário inicial do inventário';
const createInventoryDescriptionHint = 'Digite uma descrição para o inventário';
const createInventoryButtonText = 'CADASTRAR INVENTÁRIO';
// create_inventory

// inventory_details
const productsSectionTitle = "Produtos";
const addressesSectionTitle = "Endereços";
const analisysSectionTitle = "Análise";
const startedInventory = "Iniciado";
const notStartedInventory = "Não iniciado";
const finishedInventory = "Finalizado";
const importProducts = "Importar produtos";
const manageAddresses = "Gerenciar endereços";
const manageEmployees = "Gerenciar colaboradores";
// inventory_details

// import_inventory_products
const importInventoryProductsToolbarTitle = "Importar Produtos";
const importInventoryProductsInfo =
    "Aqui você pode importar produtos para o seu inventário, no formato CSV com os seguintes campos:";
const importInventoryProductsFieldsName = "NOME; EAN; EMB(UND/KG)";
const selectInventoryProductsFileGoogleDriveTitle = "Selecione o arquivo com os produtos a serem importados";
const selectInventoryProductsFileGoogleDriveInfo =
    "O arquivo deve estar no formato CSV com os seguintes campos: NOME; EAN; EMB(UND/KG)";
const confirmInventoryFileDialogTitle = "Confirmar importação";
const confirmInventoryFileDialogMessage = "Você deseja realmente importar os produtos do arquivo: ";
const confirmInventoryFileDialogPositiveButton = "Confirmar";
const confirmInventoryFileDialogNegativeButton = "Cancelar";
const confirmProductsImport = "Confirmar importação";
const importProductsSuccessTitle = "Importação com sucesso!";
const importProductsSuccessMessage = "Importação dos produtos realizada com sucesso, confira seu inventário.";
const emptyProductListMessage = 'Não há produtos disponíveis para importação neste momento, clique em + para importar.';
// import_inventory_products

// inventory_employees
const inventoryEmployeesToolbarTitle = "Gerenciar Colaboradores";
const inventoryEmployeesInfo =
    "Aqui você pode gerenciar os colaboradores do seu inventário, adicionando a inventários e removendo.";
const registerInventoryEmployeeHint = "Digite o email do colaborador";
const registerInventoryEmployeeButton = "Adicionar colaborador";
const registerInventoryEmployeeUserAlreadyRegistered = "Este usuário já está cadastrado neste inventário";
const registerInventoryEmployeeUserNotFound =
    "Não existe um usuário cadastrado com este email ou este usuário não é um colaborador";
const registerInventoryEmployeeSuccessfulTitle = "Sucesso!";
const registerInventoryEmployeeSuccessfulMessage = "O colaborador foi adicionado ao inventário com sucesso";
const emptyInventoryEmployeesListMessage = "Não existem colaboradores cadastrados neste inventário";
// inventory_employees

// inventory_locations
const inventoryLocationsToolbarTitle = 'Gerenciar Endereços';
const inventoryLocationsInfo =
    'Aqui você pode gerenciar os endereços do seu inventário e os colaboradores de cada endereço';
const inventoryLocationsEmptyListMessage = 'Não existem endereços cadastrados neste inventário, crie um para visualizá-lo';
const addInventoryLocationLocationNameFieldHint = 'Digite o nome do endereço';
const addInventoryLocationLocationDescriptionFieldHint = 'Digite a descrição do endereco (opcional)';
const addInventoryLocationInvalidNameError = 'O nome do inventário não pode estar vazio';
const addInventoryLocationAddButton = 'CRIAR ENDEREÇO';
// inventory_locations
