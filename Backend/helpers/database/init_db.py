
from .connection import get_connection

def init_database():
    conn = get_connection()
    cur = conn.cursor()

    # Cria as tabelas do banco
    with open("helpers/database/schema.sql", "r", encoding="utf-8") as f:
        sql_script = f.read()

    cur.execute(sql_script)

    # Verifica se já existem filmes cadastrados
    cur.execute("SELECT COUNT(*) FROM filme")
    total_filmes = cur.fetchone()[0]

    if total_filmes == 0:
        with open("helpers/database/seed_filmes.sql", "r", encoding="utf-8") as f:
            seed_filmes = f.read()

        cur.execute(seed_filmes)
        print("Filmes de demonstração cadastrados.")

    # Verifica se já existem administradores
    cur.execute("SELECT COUNT(*) FROM adm")
    total_adm = cur.fetchone()[0]

    if total_adm == 0:
        with open("helpers/database/seed_usuarios.sql", "r", encoding="utf-8") as f:
            seed_usuarios = f.read()

        cur.execute(seed_usuarios)
        print("Contas de demonstração cadastradas.")

    conn.commit()
    cur.close()
    conn.close()

    print("Banco inicializado com sucesso.")
