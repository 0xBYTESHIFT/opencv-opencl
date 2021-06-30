# conan-index

В docker-compose файле прописать путь до папки `conan-index/recipes`<br>
Отредактировать `build_conan_package.sh` под нужные рецепты.

Следом выполнить: 
```bash
docker-compose build
docker-compose up
```