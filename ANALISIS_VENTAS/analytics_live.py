import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine

# 1. CONFIGURAR LA CONEXIÓN LIVE A MYSQL
usuario = "root"
contrasena = "22307706GAS"  # <-- 
host = "localhost"
base_datos = "pintureria_pro"

# Creamos el puente de conexión
engine = create_engine(f"mysql+pymysql://{usuario}:{contrasena}@{host}/{base_datos}")

# 2. LA CONSULTA ANALÍTICA ADAPTADA A TU BASE DE DATOS EXACTA
query = """
SELECT 
    m.nombre AS Marca,
    SUM(p.precio * v.cantidad_vendida) AS Facturacion_Total
FROM ventas v
JOIN productos p ON v.id_producto = p.id_producto
JOIN marcas m ON p.id_marca = m.id_marca
GROUP BY m.nombre
ORDER BY Facturacion_Total DESC;
"""

print("🔄 Conectando a MySQL y extrayendo datos históricos...")
df_reporte = pd.read_sql(query, con=engine)

print("\n--- DATOS LIVE DESDE EL MOTOR DE BASE DE DATOS ---")
print(df_reporte)

# 4. VISUALIZACIÓN DE IMPACTO 
plt.figure(figsize=(8, 5))
sns.set_theme(style="whitegrid")

sns.barplot(
    x="Marca", 
    y="Facturacion_Total", 
    data=df_reporte, 
    palette="Blues_d"
)
plt.title("Reporte Gerencial: Facturación Total por Marca", fontsize=14, fontweight="bold")
plt.xlabel("Marcas Disponibles en Inventario", fontsize=12)
plt.ylabel("Flujo de Caja Acumulado ($)", fontsize=12)

plt.tight_layout()
print("\n Renderizando gráfico estadístico...")
plt.show()