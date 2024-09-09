USE [EverestIntelligent]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Apellido] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Celular] [nvarchar](15) NULL,
	[FechaCreacion] [datetime] NULL,
	[FechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_NombreApellido] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC,
	[Apellido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Tipo] [nvarchar](50) NULL,
	[FechaCreacion] [date] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnitario] [float] NULL,
	[Estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_NombreTipo] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC,
	[Tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddEmpleados]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear un nuevo empleado
CREATE PROCEDURE [dbo].[SP_AddEmpleados]
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @Email NVARCHAR(100),
    @Celular NVARCHAR(15)
AS
BEGIN
    INSERT INTO Empleados (Nombre, Apellido, Email, Celular, FechaCreacion, FechaModificacion)
    VALUES (@Nombre, @Apellido, @Email, @Celular, getdate(), getdate());
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_AddProducto]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Crear un nuevo
CREATE PROCEDURE [dbo].[SP_AddProducto]
    @Nombre NVARCHAR(100),
    @Tipo NVARCHAR(100),
	@Cantidad INT,
	@PrecioUnitario Float,
	@Estado bit
AS
BEGIN
    INSERT INTO Productos (Nombre, Tipo, FechaCreacion, Cantidad, PrecioUnitario, Estado)
    VALUES (@Nombre, @Tipo, GETDATE(),@Cantidad, @PrecioUnitario,@Estado );
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_AlterEmpleado]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Editar un empleado existente
CREATE PROCEDURE [dbo].[SP_AlterEmpleado]
    @Id INT,
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @Email NVARCHAR(100),
    @Celular NVARCHAR(15)
AS
BEGIN
    UPDATE Empleados
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        Email = @Email,
        Celular = @Celular,
        FechaModificacion = getdate()
    WHERE IdEmpleado = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_AlterProducto]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Editar
CREATE PROCEDURE [dbo].[SP_AlterProducto]
    @Id INT,
    @Nombre NVARCHAR(100),
    @Tipo NVARCHAR(100),
	@Cantidad INT,
	@PrecioUnitario Float,
	@Estado bit
AS
BEGIN
    UPDATE Productos
    SET Nombre = @Nombre,
        Tipo = @Tipo,
		Cantidad = @Cantidad,
		PrecioUnitario = @PrecioUnitario,
		Estado = @Estado
    WHERE IdProducto = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteEmpleadosId]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Borrar un empleado por ID
CREATE PROCEDURE [dbo].[SP_DeleteEmpleadosId]
    @Id INT
AS
BEGIN
    DELETE FROM Empleados WHERE IdEmpleado = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProducto]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteProducto]
    @Id INT
AS
BEGIN
    UPDATE Productos SET Estado = 0 WHERE IdProducto = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmpleados]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetEmpleados]
AS
BEGIN
    SELECT * FROM Empleados;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmpleadosContratado]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Obtener un empleado por fecha
CREATE PROCEDURE [dbo].[SP_GetEmpleadosContratado]
    @FechaInicial date,
	@FechaFinal date
AS
BEGIN
    SELECT * FROM Empleados WHERE Convert(date,FechaCreacion) between @FechaInicial and @FechaFinal ;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetEmpleadosId]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Obtener un empleado por ID
CREATE PROCEDURE [dbo].[SP_GetEmpleadosId]
    @Id INT
AS
BEGIN
    SELECT * FROM Empleados WHERE IdEmpleado = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProducto]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_GetProducto]
AS
BEGIN
    SELECT * FROM Productos WHERE Estado = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductoId]    Script Date: 9/09/2024 3:52:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Obtener Producto Id
Create PROCEDURE [dbo].[SP_GetProductoId]
    @Id INT
AS
BEGIN
    SELECT * FROM Productos WHERE IdProducto = @Id;
END;
GO
