CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`CURSOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CURSOS` (
  `codigo` INT NOT NULL,
  `materias` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `carga horarias` TIME NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ALUNOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ALUNOS` (
  `matricula` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `sobrenome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `curso` VARCHAR(45) NOT NULL,
  `disciplinas` VARCHAR(45) NOT NULL,
  `materias` VARCHAR(45) NOT NULL,
  `CURSOS_codigo` INT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_ALUNOS_CURSOS1_idx` (`CURSOS_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_ALUNOS_CURSOS1`
    FOREIGN KEY (`CURSOS_codigo`)
    REFERENCES `mydb`.`CURSOS` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PROFESSORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PROFESSORES` (
  `matricula` SMALLINT(4) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`matricula`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DISCIPLINAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DISCIPLINAS` (
  `codigo` INT NOT NULL,
  `maxAlunos` INT NOT NULL,
  `PROFESSORES_matricula` SMALLINT(4) NOT NULL,
  `ALUNOS_matricula` INT NOT NULL,
  PRIMARY KEY (`codigo`, `ALUNOS_matricula`),
  INDEX `fk_DISCIPLINAS_PROFESSORES1_idx` (`PROFESSORES_matricula` ASC) VISIBLE,
  INDEX `fk_DISCIPLINAS_ALUNOS1_idx` (`ALUNOS_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_DISCIPLINAS_PROFESSORES1`
    FOREIGN KEY (`PROFESSORES_matricula`)
    REFERENCES `mydb`.`PROFESSORES` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DISCIPLINAS_ALUNOS1`
    FOREIGN KEY (`ALUNOS_matricula`)
    REFERENCES `mydb`.`ALUNOS` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MATERIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MATERIAS` (
  `codigo` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `pre-requisito(s)` VARCHAR(45) NOT NULL,
  `DISCIPLINAS_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_MATERIAS_DISCIPLINAS1_idx` (`DISCIPLINAS_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_MATERIAS_DISCIPLINAS1`
    FOREIGN KEY (`DISCIPLINAS_codigo`)
    REFERENCES `mydb`.`DISCIPLINAS` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CURSOS_has_MATERIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CURSOS_has_MATERIAS` (
  `CURSOS_codigo` INT NOT NULL,
  `MATERIAS_codigo` INT NOT NULL,
  PRIMARY KEY (`CURSOS_codigo`, `MATERIAS_codigo`),
  INDEX `fk_CURSOS_has_MATERIAS_MATERIAS1_idx` (`MATERIAS_codigo` ASC) VISIBLE,
  INDEX `fk_CURSOS_has_MATERIAS_CURSOS_idx` (`CURSOS_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_CURSOS_has_MATERIAS_CURSOS`
    FOREIGN KEY (`CURSOS_codigo`)
    REFERENCES `mydb`.`CURSOS` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CURSOS_has_MATERIAS_MATERIAS1`
    FOREIGN KEY (`MATERIAS_codigo`)
    REFERENCES `mydb`.`MATERIAS` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;