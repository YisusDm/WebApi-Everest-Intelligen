using System.Data;
using System.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using WebApi_Everest_Intelligent.Models;
using Microsoft.Data.SqlClient;

namespace WebApi_Everest_Intelligent.Datos
{
    public class ProductoRepository
    {
        private readonly string _connectionString;

        public ProductoRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("cadenaSQL");
        }

        // Obtener todos los usuarios
        public async Task<IEnumerable<Producto>> ObtenerProductosAsync()
        {
            var productos = new List<Producto>();

            using (var connection = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SP_GetProducto", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                connection.Open();
                using (var reader = await command.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        productos.Add(new Producto
                        {
                            IdProducto = reader.GetInt32(0),
                            Nombre = reader.GetString(1),
                            Tipo = reader.GetString(2),
                            FechaCreacion = reader.GetDateTime(3),
                            Cantidad = reader.GetInt32(4),
                            PrecioUnitario = reader.GetDouble(5),
                            Estado = reader.GetBoolean(6),
                        });
                    }
                }
            }

            return productos;
        }

        // Crear
        public async Task CrearProductosAsync(Producto producto)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SP_AddProducto", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Nombre", producto.Nombre);
                command.Parameters.AddWithValue("@Tipo", producto.Tipo);
                command.Parameters.AddWithValue("@Cantidad", producto.Cantidad);
                command.Parameters.AddWithValue("@PrecioUnitario", producto.PrecioUnitario);
                command.Parameters.AddWithValue("@Estado", producto.Estado);

                connection.Open();
                await command.ExecuteNonQueryAsync();
            }
        }

        // Editar
        public async Task EditarProductosAsync(Producto producto)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SP_AlterProducto", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Id", producto.IdProducto);
                command.Parameters.AddWithValue("@Nombre", producto.Nombre);
                command.Parameters.AddWithValue("@Tipo", producto.Tipo);
                command.Parameters.AddWithValue("@Cantidad", producto.Cantidad);
                command.Parameters.AddWithValue("@PrecioUnitario", producto.PrecioUnitario);
                command.Parameters.AddWithValue("@Estado", producto.Estado);

                connection.Open();
                await command.ExecuteNonQueryAsync();
            }
        }

        // Borrar
        public async Task BorrarProductosAsync(int id)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SP_DeleteProducto", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Id", id);

                connection.Open();
                await command.ExecuteNonQueryAsync();
            }
        }

        // Obtener Usuario por ID
        public async Task<Producto> ObtenerProductosIdAsync(int id)
        {
            Producto producto = null;

            using (var connection = new SqlConnection(_connectionString))
            {
                var command = new SqlCommand("SP_GetProductoId", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.AddWithValue("@Id", id);

                connection.Open();
                using (var reader = await command.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        producto = new Producto
                        {
                            IdProducto = reader.GetInt32(0),
                            Nombre = reader.GetString(1),
                            Tipo = reader.GetString(2),
                            FechaCreacion = reader.GetDateTime(3),
                            Cantidad = reader.GetInt32(4),
                            PrecioUnitario = reader.GetDouble(5),
                            Estado = reader.GetBoolean(6),
                        };
                    }
                }
            }

            return producto;
        }


    }
}
