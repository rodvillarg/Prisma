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
CREATE TABLE `vehiculos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `clienteId` INTEGER NOT NULL,
    `placa` VARCHAR(10) NOT NULL,
    `marca` VARCHAR(30) NOT NULL,
    `modelo` VARCHAR(30) NOT NULL,
    `anio` INTEGER NOT NULL,

    UNIQUE INDEX `vehiculos_placa_key`(`placa`),
    INDEX `vehiculos_clienteId_idx`(`clienteId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ordenes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vehiculoId` INTEGER NOT NULL,
    `descripcion` VARCHAR(255) NOT NULL,
    `fechaIngreso` DATE NOT NULL,
    `estado` ENUM('abierta', 'en_proceso', 'entregada', 'cancelada') NOT NULL DEFAULT 'abierta',

    INDEX `ordenes_vehiculoId_idx`(`vehiculoId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `refacciones` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ordenId` INTEGER NOT NULL,
    `nombre` VARCHAR(30) NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL,

    INDEX `refacciones_ordenId_idx`(`ordenId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `vehiculos` ADD CONSTRAINT `vehiculos_clienteId_fkey` FOREIGN KEY (`clienteId`) REFERENCES `clientes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ordenes` ADD CONSTRAINT `ordenes_vehiculoId_fkey` FOREIGN KEY (`vehiculoId`) REFERENCES `vehiculos`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `refacciones` ADD CONSTRAINT `refacciones_ordenId_fkey` FOREIGN KEY (`ordenId`) REFERENCES `ordenes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
