# Use an official Elixir runtime as a parent image
FROM elixir:latest

# Install PostgreSQL client and netcat
RUN apt-get update && apt-get install -y postgresql-client netcat-openbsd

# Set the working directory in the container
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Copy the current directory contents into the container at /app
COPY . .

# Install dependencies
RUN mix deps.get

# Compile the project
RUN mix do compile

# Expose the port the app runs on
EXPOSE 4000

# Define environment variables:
ENV MIX_ENV=prod \
    PORT=4000 \
    SECRET_KEY_BASE=nokey

# Wait for the database to be ready and run migrations
CMD ["./wait-for", "db:5432", "--", "sh", "-c", "mix ecto.setup && mix phx.server"]
