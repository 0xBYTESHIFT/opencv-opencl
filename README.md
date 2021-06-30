# Instrucions

build: 

```bash
docker build . -t ocl_ocv
```

run:

```bash
docker run ocl_ocv
```

desired output: "YOU HAVE OPENCL"
actual output: "NO OPENCL"

reason is unknown. opencv links with opencl just fine during conan create/export stage. but then application itself can't use opencl somehow.
