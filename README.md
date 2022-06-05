# README

Para el desarrollo de la prueba se ha utilizado rubi on rails.

- La lógica de la aplicación se centra en ChuckController:
  - Al entrar en la aplicación (http://localhost:3000/) el controlador se encarga de obtener las categorías por las que se puede filtrar.
  - Una vez se hace una consulta se comprueba que tipo de consulta es (aleatoria, palabras o categoría) y realiza la petición correspondiente a la API validando si se devuelve un error para mostrarlo en la ventana.
  - Cuando la API no devuelve ningún error se devolverán todos los resultados en un array para mostrarlos en la ventana y los guardara en BBDD por el método save_request.
  - Si se ha introducido un email en el campo "Email" también se mandara un email utilizando el Mailer RequestMailer.

- En la ventana de index se ha creado un formulario que filtra con un radio button el tipo de consulta que se quiere realizar así como los campos necesarios para cada una.

- En la ventana de search se reciben los resultados de la consulta en un array, estos se insertan en una array de JavaScript la cual se utiliza para mostrar los resultados de forma paginada.

- Para los idiomas de la aplicación se a utilizado la librería i18n.

- La base de datos esta estructurada en dos tablas "Requests" y "Responses", en "Request" se guardan los datos de la petición y en "Response" se guardan con una referencia a "Request" todas las respuestas devueltas por la API.
