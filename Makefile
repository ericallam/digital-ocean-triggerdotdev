MAKEFLAGS += --silent
include .env
export $(shell sed 's/=.*//' .env)

dev:
	npm run dev

install:
	npm install --omit=dev

start: install
	npm run start

.PHONY: dev start