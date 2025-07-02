FROM python:3.13.5-alpine3.22

# 2. Definir o diretório de trabalho no contêiner
WORKDIR /app

# 3. Copiar o arquivo de dependências para o diretório de trabalho
# Isso aproveita o cache do Docker. As dependências só serão reinstaladas se o requirements.txt mudar.
COPY requirements.txt .

# 4. Instalar as dependências
# --no-cache-dir: Desabilita o cache do pip, o que reduz o tamanho da imagem.
# --upgrade pip: Garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho
COPY . .

# 6. Expor a porta em que a aplicação será executada (padrão do uvicorn é 8000)
EXPOSE 8000

# 7. Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
# O --reload não é usado em produção, apenas para desenvolvimento.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000","--reload"]