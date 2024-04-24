-- -----------------------------------------------------
-- Schema dw_restaurante
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dw_restaurante` DEFAULT CHARACTER SET utf8 ;

USE `dw_restaurante` ;

-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_Local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_Local` (
  `idLocal` INT NOT NULL AUTO_INCREMENT,
  `NombreLocal` VARCHAR(50) NOT NULL,
  `Direccion` VARCHAR(50) NOT NULL,
  `Distrito` VARCHAR(50) NOT NULL,
  `HorarioAtencion` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idLocal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_Mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_Mesa` (
  `idMesa` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(10) NOT NULL,
  `Capacidad` TINYINT NULL,
  PRIMARY KEY (`idMesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `ApePaterno` VARCHAR(40) NULL,
  `ApeMaterno` VARCHAR(40) NULL,
  `Nombres` VARCHAR(40) NULL,
  `Email` VARCHAR(40) NULL,
  `Telefono` VARCHAR(15) NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_Trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_Trabajador` (
  `idTrabajador` INT NOT NULL AUTO_INCREMENT,
  `ApellidosNombres` VARCHAR(120) NOT NULL,
  `Local` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idTrabajador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_Tiempo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_Tiempo` (
  `idTiempo` INT NOT NULL,
  `Anio` INT NOT NULL,
  `Mes` INT NOT NULL,
  `Dia` INT NOT NULL,
  `Trimestre` INT NOT NULL,
  `DiaSemana` INT NOT NULL,
  `DiaAnio` INT NOT NULL,
  `SemanaAnio` INT NOT NULL,
  `FinSemana` TINYINT NOT NULL,
  PRIMARY KEY (`idTiempo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Hec_Fact_Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Hec_Fact_Pedidos` (
  `idPedidos` INT NOT NULL AUTO_INCREMENT,
  `idLocal` INT NOT NULL,
  `idMesa` INT NOT NULL,
  `idClientes` INT NOT NULL,
  `idTrabajador` INT NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `TipoConsumo` CHAR(1) NOT NULL,
  `idDireccionEnvio` INT NULL,
  `ItemsTotal` INT NOT NULL,
  `PrecioTotal` DECIMAL(10,2) NOT NULL,
  `Dim_Tiempo_idTiempo` INT NOT NULL,
  PRIMARY KEY (`idPedidos`),
  INDEX `fk_Pedidos_Local1_idx` (`idLocal` ASC) VISIBLE,
  INDEX `fk_Pedidos_Mesa1_idx` (`idMesa` ASC) VISIBLE,
  INDEX `fk_Pedidos_Clientes1_idx` (`idClientes` ASC) VISIBLE,
  INDEX `fk_Pedidos_Trabajador1_idx` (`idTrabajador` ASC) VISIBLE,
  INDEX `fk_Hec_Fact_Pedidos_Dim_Tiempo1_idx` (`Dim_Tiempo_idTiempo` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Local1`
    FOREIGN KEY (`idLocal`)
    REFERENCES `dw_restaurante`.`Dim_Local` (`idLocal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Mesa1`
    FOREIGN KEY (`idMesa`)
    REFERENCES `dw_restaurante`.`Dim_Mesa` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`idClientes`)
    REFERENCES `dw_restaurante`.`Dim_Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Trabajador1`
    FOREIGN KEY (`idTrabajador`)
    REFERENCES `dw_restaurante`.`Dim_Trabajador` (`idTrabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Hec_Fact_Pedidos_Dim_Tiempo1`
    FOREIGN KEY (`Dim_Tiempo_idTiempo`)
    REFERENCES `dw_restaurante`.`Dim_Tiempo` (`idTiempo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_Carta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_Carta` (
  `idCarta` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Descripcion` VARCHAR(250) NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  `Estado` BIT NOT NULL DEFAULT 1,
  `Categoria` VARCHAR(30) NOT NULL,
  `SubCategoria` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idCarta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_PedidosDetalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_PedidosDetalle` (
  `idPedidos` INT NOT NULL,
  `idCarta` INT NOT NULL,
  `Cantidad` TINYINT NOT NULL,
  `PrecioUnitario` DECIMAL(10,2) NOT NULL,
  `Precio` DECIMAL(10,2) NOT NULL,
  INDEX `fk_PedidosDetalle_Carta1_idx` (`idCarta` ASC) INVISIBLE,
  INDEX `fk_PedidosDetalle_Pedidos1_idx` (`idPedidos` ASC) INVISIBLE,
  CONSTRAINT `fk_PedidosDetalle_Pedidos1`
    FOREIGN KEY (`idPedidos`)
    REFERENCES `dw_restaurante`.`Hec_Fact_Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PedidosDetalle_Carta1`
    FOREIGN KEY (`idCarta`)
    REFERENCES `dw_restaurante`.`Dim_Carta` (`idCarta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_restaurante`.`Dim_Direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_restaurante`.`Dim_Direcciones` (
  `idDirecciones` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(100) NOT NULL,
  `Distrito` VARCHAR(50) NOT NULL,
  `idClientes` INT NOT NULL,
  `Estado` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idDirecciones`),
  INDEX `fk_Direcciones_Clientes1_idx` (`idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Direcciones_Clientes1`
    FOREIGN KEY (`idClientes`)
    REFERENCES `dw_restaurante`.`Dim_Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
