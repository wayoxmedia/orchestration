#!/bin/bash

# === CONFIG ===
ALL_SERVICES=("mystorepanel" "template1" "template2" "template3" "template4" "template5" "template6" "template7" "web-templates")
COMPOSE_PROJECT_DIR="$(dirname "$0")"
SELECTED_SERVICES=()

# === FUNCTIONS ===

ask_for_service() {
  local name=$1
  read -rp "¿Quieres levantar '$name'? (s/n): " answer
  if [[ "$answer" =~ ^[Ss]$ ]]; then
    SELECTED_SERVICES+=("$name")
  fi
}

# === EXECUTION ===

echo "🎛️ ¿Qué servicios quieres levantar?"
for service in "${ALL_SERVICES[@]}"; do
  ask_for_service "$service"
done

# Incluir siempre el proxy si se seleccionó al menos uno
if [[ ${#SELECTED_SERVICES[@]} -gt 0 ]]; then
  SELECTED_SERVICES=("apache-proxy" "${SELECTED_SERVICES[@]}")
fi

echo ""
echo "🐳 Levantando contenedores seleccionados: ${SELECTED_SERVICES[*]}"
cd "$COMPOSE_PROJECT_DIR" || exit 1
docker compose up -d "${SELECTED_SERVICES[@]}"

echo ""
echo "🚀 Contenedores activos:"
for service in "${SELECTED_SERVICES[@]}"; do
  [[ "$service" != "apache-proxy" ]] && echo " - http://${service}.test"
done
