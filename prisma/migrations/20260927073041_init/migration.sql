-- CreateTable
CREATE TABLE `clientes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(100) NOT NULL,
    `telefono` VARCHAR(20) NOT NULL,
    `correo` VARCHAR(80) NOT NULL,

    UNIQUE INDEX `clientes_correo_key`(`correo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mesas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `numero` INTEGER NOT NULL,
    `capacidad` INTEGER NOT NULL,

    UNIQUE INDEX `mesas_numero_key`(`numero`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `turnos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(30) NOT NULL,
    `horaInicio` TIME NOT NULL,
    `horaFin` TIME NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reservaciones` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `clienteId` INTEGER NOT NULL,
    `mesaId` INTEGER NOT NULL,
    `turnoId` INTEGER NOT NULL,
    `fecha` DATE NOT NULL,
    `estado` ENUM('confirmada', 'cancelada', 'completada') NOT NULL DEFAULT 'confirmada',

    INDEX `reservaciones_clienteId_idx`(`clienteId`),
    INDEX `reservaciones_turnoId_idx`(`turnoId`),
    UNIQUE INDEX `reservaciones_mesaId_turnoId_key`(`mesaId`, `turnoId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `reservaciones` ADD CONSTRAINT `reservaciones_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `clientes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservaciones` ADD CONSTRAINT `reservaciones_mesaId_fkey` FOREIGN KEY (`mesaId`) REFERENCES `mesas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservaciones` ADD CONSTRAINT `reservaciones_turnoId_fkey` FOREIGN KEY (`turnoId`) REFERENCES `turnos`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
