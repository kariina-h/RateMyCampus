SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`acesso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`acesso` (
  `idacesso` INT(11) NOT NULL AUTO_INCREMENT ,
  `tipoacesso` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idacesso`) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`campus`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`campus` (
  `idcampus` INT(11) NOT NULL AUTO_INCREMENT ,
  `nomecampus` VARCHAR(45) NOT NULL ,
  `logocampus` BLOB NULL DEFAULT NULL ,
  `nomeuniversidade` VARCHAR(45) NULL DEFAULT NULL ,
  `logouniversidade` BLOB NULL DEFAULT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cidade` VARCHAR(45) NOT NULL ,
  `estado` VARCHAR(45) NOT NULL ,
  `campuscol` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idcampus`) )
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT(11) NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `login` VARCHAR(20) NOT NULL ,
  `senha` VARCHAR(20) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `tipousuario` INT(11) NOT NULL ,
  `campususu` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idusuario`) ,
  INDEX `tipousuario_idx` (`tipousuario` ASC) ,
  INDEX `campus_idx` (`campususu` ASC) ,
  CONSTRAINT `ccampus`
    FOREIGN KEY (`campususu` )
    REFERENCES `mydb`.`campus` (`idcampus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ctipousuario`
    FOREIGN KEY (`tipousuario` )
    REFERENCES `mydb`.`acesso` (`idacesso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`biblioteca`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`biblioteca` (
  `idbiblioteca` INT(11) NOT NULL AUTO_INCREMENT ,
  `nomebiblioteca` VARCHAR(45) NOT NULL ,
  `campusbiblio` INT(11) NOT NULL ,
  `descricaobiblioteca` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idbiblioteca`) ,
  INDEX `campusbiblio_idx` (`campusbiblio` ASC) ,
  CONSTRAINT `ccampusbiblio`
    FOREIGN KEY (`campusbiblio` )
    REFERENCES `mydb`.`campus` (`idcampus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacaobiblioteca`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`avaliacaobiblioteca` (
  `idavaliacaobiblioteca` INT(11) NOT NULL AUTO_INCREMENT ,
  `avaliador` INT(11) NOT NULL ,
  `biblioteca` INT(11) NOT NULL ,
  `acervo` INT(11) NULL DEFAULT NULL ,
  `atendimento` INT(11) NULL DEFAULT NULL ,
  `organizacao` INT(11) NULL DEFAULT NULL ,
  `infraestrutura` INT(11) NULL DEFAULT NULL ,
  `materiaisdisponiveis` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idavaliacaobiblioteca`) ,
  INDEX `avaliador_idx` (`avaliador` ASC) ,
  INDEX `biblioteca_idx` (`biblioteca` ASC) ,
  CONSTRAINT `cavaliador`
    FOREIGN KEY (`avaliador` )
    REFERENCES `mydb`.`usuario` (`idusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cbiblioteca`
    FOREIGN KEY (`biblioteca` )
    REFERENCES `mydb`.`biblioteca` (`idbiblioteca` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`curso` (
  `idcurso` INT(11) NOT NULL AUTO_INCREMENT ,
  `nomecurso` VARCHAR(45) NOT NULL ,
  `campuscur` INT(11) NOT NULL ,
  `descricaocurso` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idcurso`) ,
  INDEX `campuscur_idx` (`campuscur` ASC) ,
  CONSTRAINT `ccampuscur`
    FOREIGN KEY (`campuscur` )
    REFERENCES `mydb`.`campus` (`idcampus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacaocurso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`avaliacaocurso` (
  `idavaliacaocurso` INT(11) NOT NULL AUTO_INCREMENT ,
  `avaliador` INT(11) NOT NULL ,
  `curso` INT(11) NOT NULL ,
  `catalogo` INT(11) NULL DEFAULT NULL ,
  `evasao` INT(11) NULL DEFAULT NULL ,
  `professores` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idavaliacaocurso`) ,
  INDEX `avaliador_idx` (`avaliador` ASC) ,
  INDEX `curso_idx` (`curso` ASC) ,
  CONSTRAINT `ccccavaliador`
    FOREIGN KEY (`avaliador` )
    REFERENCES `mydb`.`usuario` (`idusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ccurso`
    FOREIGN KEY (`curso` )
    REFERENCES `mydb`.`curso` (`idcurso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`professor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`professor` (
  `idprofessor` INT(11) NOT NULL AUTO_INCREMENT ,
  `nomeprofessor` VARCHAR(45) NOT NULL ,
  `campusprof` INT(11) NOT NULL ,
  `descricaoprofessor` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idprofessor`) ,
  INDEX `campusprof_idx` (`campusprof` ASC) ,
  CONSTRAINT `ccampusprof`
    FOREIGN KEY (`campusprof` )
    REFERENCES `mydb`.`campus` (`idcampus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacaoprofessor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`avaliacaoprofessor` (
  `idavaliacaoprofessor` INT(11) NOT NULL AUTO_INCREMENT ,
  `avaliador` INT(11) NOT NULL ,
  `professor` INT(11) NOT NULL ,
  `didatica` INT(11) NULL DEFAULT NULL ,
  `usodemateriais` INT(11) NULL DEFAULT NULL ,
  `pontualidade` INT(11) NULL DEFAULT NULL ,
  `comprometimento` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idavaliacaoprofessor`) ,
  INDEX `avaliador_idx` (`avaliador` ASC) ,
  INDEX `professor_idx` (`professor` ASC) ,
  CONSTRAINT `ccavaliador`
    FOREIGN KEY (`avaliador` )
    REFERENCES `mydb`.`usuario` (`idusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cprofessor`
    FOREIGN KEY (`professor` )
    REFERENCES `mydb`.`professor` (`idprofessor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`restaurante`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`restaurante` (
  `idrestaurante` INT(11) NOT NULL AUTO_INCREMENT ,
  `nomerestaurante` VARCHAR(45) NOT NULL ,
  `campusres` INT(11) NOT NULL ,
  `descricaorestaurante` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idrestaurante`) ,
  INDEX `campusres_idx` (`campusres` ASC) ,
  CONSTRAINT `ccampusres`
    FOREIGN KEY (`campusres` )
    REFERENCES `mydb`.`campus` (`idcampus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacaorestaurante`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`avaliacaorestaurante` (
  `idavaliacaorestaurante` INT(11) NOT NULL AUTO_INCREMENT ,
  `avaliador` INT(11) NOT NULL ,
  `restaurante` INT(11) NOT NULL ,
  `preco` INT(11) NULL DEFAULT NULL ,
  `refeicoes` INT(11) NULL DEFAULT NULL ,
  `higiene` INT(11) NULL DEFAULT NULL ,
  `logistica` INT(11) NULL DEFAULT NULL ,
  `infraestrutura` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idavaliacaorestaurante`) ,
  INDEX `avaliador_idx` (`avaliador` ASC) ,
  INDEX `restaurante_idx` (`restaurante` ASC) ,
  CONSTRAINT `avaliador`
    FOREIGN KEY (`avaliador` )
    REFERENCES `mydb`.`usuario` (`idusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `restaurante`
    FOREIGN KEY (`restaurante` )
    REFERENCES `mydb`.`restaurante` (`idrestaurante` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`sala`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`sala` (
  `idsala` INT(11) NOT NULL AUTO_INCREMENT ,
  `nomesala` VARCHAR(45) NOT NULL ,
  `campussal` INT(11) NOT NULL ,
  `descricaosala` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idsala`) ,
  INDEX `campussal_idx` (`campussal` ASC) ,
  CONSTRAINT `ccampussal`
    FOREIGN KEY (`campussal` )
    REFERENCES `mydb`.`campus` (`idcampus` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`avaliacaosala`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`avaliacaosala` (
  `idavaliacaosala` INT(11) NOT NULL AUTO_INCREMENT ,
  `avaliador` INT(11) NOT NULL ,
  `sala` INT(11) NOT NULL ,
  `higiene` INT(11) NULL DEFAULT NULL ,
  `infraestrutura` INT(11) NULL DEFAULT NULL ,
  `materiaisdisponiveis` INT(11) NULL DEFAULT NULL ,
  `condicaodosmateriais` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`idavaliacaosala`) ,
  INDEX `avaliador_idx` (`avaliador` ASC) ,
  INDEX `sala_idx` (`sala` ASC) ,
  CONSTRAINT `cccavaliador`
    FOREIGN KEY (`avaliador` )
    REFERENCES `mydb`.`usuario` (`idusuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `csala`
    FOREIGN KEY (`sala` )
    REFERENCES `mydb`.`sala` (`idsala` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
