package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
)

type Libro struct {
	Id      string `json:"id"`
	Nombre  string `json:"nombre"`
	Isbn    string `json:"isbn"`
	IdAutor string `json:"idAutor"`

	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
}

type Autor struct {
	Id        string `json:"id"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
}

type Usuario struct {
	Id       string `json:"id"`
	Nombre   string `json:"nombre"`
	Password string `json:"password"`
	Email    string `json:"email"`
	Rol      string `json:"rol"`
	Tok      string `json:"tok"`
}

var db *sql.DB
var err error

func main() {
	db, err = sql.Open("mysql", "root:@tcp(127.0.0.1:3306)/libreria")
	if err != nil {
		panic(err.Error())
	}

	defer db.Close()

	router := mux.NewRouter()

	router.HandleFunc("/api/libros", getLibros).Methods("GET")
	router.HandleFunc("/api/libros/autor/{id}", getLibrosByAutor).Methods("GET")
	router.HandleFunc("/api/libros/all", getAll).Methods("GET")
	router.HandleFunc("/api/libros/{id}", getLibro).Methods("GET")
	router.HandleFunc("/api/libros", postLibro).Methods("POST")
	router.HandleFunc("/api/libros/{id}", putLibro).Methods("PUT")
	router.HandleFunc("/api/libros/{id}", deleteLibro).Methods("DELETE")

	router.HandleFunc("/api/autores", getAutores).Methods("GET")
	router.HandleFunc("/api/autores/{id}", getAutor).Methods("GET")
	router.HandleFunc("/api/autores", postAutor).Methods("POST")
	router.HandleFunc("/api/autores/{id}", putAutor).Methods("PUT")
	router.HandleFunc("/api/autores/{id}", deleteAutor).Methods("DELETE")

	router.HandleFunc("/api/usuarios", getUsuarios).Methods("GET")
	router.HandleFunc("/api/usuarios/{id}", getUsuario).Methods("GET")
	router.HandleFunc("/api/usuarios", postUsuario).Methods("POST")
	router.HandleFunc("/api/usuarios/{id}", putUsuario).Methods("PUT")
	router.HandleFunc("/api/usuarios/{id}", deleteUsuario).Methods("DELETE")

	http.ListenAndServe(":8000", router)

}

/////////////////////////////////// INICIO API LIBROS ////////////////////////////

////////////////// GET LIBROS ////////////////////////
func getLibros(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var libros []Libro

	result, err := db.Query("SELECT * FROM books")
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	for result.Next() {
		var libro Libro
		err := result.Scan(&libro.Id, &libro.Nombre, &libro.Isbn, &libro.IdAutor)
		if err != nil {
			panic(err.Error())
		}
		libros = append(libros, libro)
	}

	json.NewEncoder(w).Encode(libros)

	fmt.Println("ESTO ES GET LIBROS")
}

/////////////// GET LIBROS POR AUTOR ///////////////////////////
func getLibrosByAutor(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var libros []Libro

	params := mux.Vars(r)

	result, err := db.Query("SELECT * FROM books WHERE idAutor = ?", params["id"])
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	for result.Next() {
		var libro Libro
		err := result.Scan(&libro.Id, &libro.Nombre, &libro.Isbn, &libro.IdAutor)
		if err != nil {
			panic(err.Error())
		}
		libros = append(libros, libro)
	}
	json.NewEncoder(w).Encode(libros)

	fmt.Println("ESTO ES GET LIBRO POR AUTOR")
}

/////////////////////// GET TODO ////////////////////
func getAll(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	var libros []Libro

	result, err := db.Query("SELECT b.id, b.nombre, b.isbn, b.idAutor, a.first_name, a.last_name FROM books b INNER JOIN autor a ON b.idAutor = a.id")
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	for result.Next() {
		var libro Libro

		err := result.Scan(&libro.Id, &libro.Nombre, &libro.Isbn, &libro.IdAutor, &libro.FirstName, &libro.LastName)
		if err != nil {
			panic(err.Error())
		}
		libros = append(libros, libro)
	}
	json.NewEncoder(w).Encode(libros)

	fmt.Println("ESTO ES GET ALL")
}

/////////////// GET LIBRO POR ID /////////////////////
func getLibro(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	params := mux.Vars(r)

	result, err := db.Query("SELECT * FROM books WHERE id = ?", params["id"])
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	var libro Libro

	for result.Next() {
		err := result.Scan(&libro.Id, &libro.Nombre, &libro.Isbn, &libro.IdAutor)
		if err != nil {
			panic(err.Error())
		}
	}
	json.NewEncoder(w).Encode(libro)

	fmt.Println("ESTO ES GET BY ID")
}

//////////////////// POST LIBRO ///////////////////////
func postLibro(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	stmt, err := db.Prepare("INSERT INTO books(id, nombre, isbn, idAutor) VALUES(?,?,?,?)")
	if err != nil {
		panic(err.Error())
	}
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		panic(err.Error())
	}
	keyVal := make(map[string]string)
	json.Unmarshal(body, &keyVal)

	id := keyVal["id"]
	nombre := keyVal["nombre"]
	isbn := keyVal["isbn"]
	idAutor := keyVal["idAutor"]

	_, err = stmt.Exec(&id, &nombre, &isbn, &idAutor)
	if err != nil {
		panic(err.Error())
	}
	fmt.Fprintf(w, "Se a añadido un nuevo libro")

	fmt.Println("ESTO ES POST LIBRO")
}

///////////////////// PUT LIBRO /////////////////////
func putLibro(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	params := mux.Vars(r)

	stmt, err := db.Prepare("UPDATE books SET id = ?, nombre = ?, isbn = ?, idAutor = ? WHERE id = ?")
	if err != nil {
		panic(err.Error())
	}

	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		panic(err.Error())
	}

	claveValor := make(map[string]string)
	json.Unmarshal(body, &claveValor)

	newId := claveValor["id"]
	newNombre := claveValor["nombre"]
	newIsbn := claveValor["isbn"]
	newIdAutor := claveValor["idAutor"]

	_, err = stmt.Exec(&newId, &newNombre, &newIsbn, &newIdAutor, params["id"])
	if err != nil {
		panic(err.Error())
	}

	fmt.Fprintf(w, "El registro con Id %s se ha actualizado correctamente", params["id"])
	fmt.Println("ESTO ES PUT LIBRO")
}

////////////////// DELETE LIBRO /////////////////////////
func deleteLibro(w http.ResponseWriter, r *http.Request) {
	params := mux.Vars(r)

	stmt, err := db.Prepare("DELETE FROM books WHERE id = ?")
	if err != nil {
		panic(err.Error())
	}

	_, err = stmt.Exec(params["id"])
	if err != nil {
		panic(err.Error())
	}

	fmt.Fprintf(w, "Se ha eliminado el libro con Id %s", params["id"])
	fmt.Println("ESTO ES DELETE LIBRO")
}

//////////////////////////////////// FIN API LIBROS ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////// INICIO API AUTORES ///////////////////////////

//////////////////////// GET AUTORES ///////////////////
func getAutores(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var autores []Autor

	result, err := db.Query("SELECT * FROM autor")
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	for result.Next() {
		var autor Autor
		err := result.Scan(&autor.Id, &autor.FirstName, &autor.LastName)
		if err != nil {
			panic(err.Error())
		}
		autores = append(autores, autor)
	}
	json.NewEncoder(w).Encode(autores)

	fmt.Println("ESTOS SON TODOS LOS AUTORES")
}

/////////////////// GET AUTOR POR ID //////////////////
func getAutor(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	params := mux.Vars(r)

	result, err := db.Query("SELECT * FROM autor WHERE id = ?", params["id"])
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	var autor Autor

	for result.Next() {
		err := result.Scan(&autor.Id, &autor.FirstName, &autor.LastName)
		if err != nil {
			panic(err.Error())
		}
	}
	json.NewEncoder(w).Encode(autor)

	fmt.Println("ESTO ES GET AUTOR POR ID")

}

/////////////////////// POST AUTOR ////////////////////
func postAutor(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	stmt, err := db.Prepare("INSERT INTO autor(id, first_name, last_name) VALUES (?,?,?)")
	if err != nil {
		panic(err.Error())
	}
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		panic(err.Error())
	}
	clave := make(map[string]string)
	json.Unmarshal(body, &clave)

	id := clave["id"]
	firstName := clave["first_name"]
	lastName := clave["last_name"]

	_, err = stmt.Exec(&id, &firstName, &lastName)
	if err != nil {
		panic(err.Error())
	}
	fmt.Fprintf(w, "Se a añadido un nuevo autor con id %s ", clave["id"])

	fmt.Println("ESTO ES POST AUTOR")
}

////////////////////// PUT AUTOR //////////////////////
func putAutor(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	params := mux.Vars(r)

	stmt, err := db.Prepare("UPDATE autor SET id = ?, first_name = ?, last_name = ? WHERE id = ?")
	if err != nil {
		panic(err.Error())
	}

	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		panic(err.Error())
	}

	key := make(map[string]string)
	json.Unmarshal(body, &key)

	nuevoId := key["id"]
	nuevoFirstName := key["first_name"]
	nuevoLastName := key["last_name"]

	_, err = stmt.Exec(&nuevoId, &nuevoFirstName, &nuevoLastName, params["id"])
	if err != nil {
		panic(err.Error())
	}
	fmt.Fprintf(w, "Se ha actualizado el autor con id %s correctamente", params["id"])

	fmt.Println("ESTO ES UPDATE AUTOR")
}

//////////////////// DELETE AUTOR ////////////////////////
func deleteAutor(w http.ResponseWriter, r *http.Request) {

	params := mux.Vars(r)

	stmt, err := db.Prepare("DELETE FROM autor WHERE id = ?")
	if err != nil {
		panic(err.Error())
	}

	_, err = stmt.Exec(params["id"])
	if err != nil {
		panic(err.Error())
	}

	fmt.Fprintf(w, "Se ha eliminado el autor %s correctamente ", params["id"])
	fmt.Println("ESTO ES DELETE AUTOR")
}

//////////////////////////////// FIN API AUTORES //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// INICIO  API USUARIOS //////////////////////////////

////////////////// GET USUARIOS /////////////////////////
func getUsuarios(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var usuarios []Usuario

	result, err := db.Query("SELECT * FROM usuarios")
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	for result.Next() {
		var usuario Usuario
		err := result.Scan(&usuario.Id, &usuario.Nombre, &usuario.Password, &usuario.Email, &usuario.Rol, &usuario.Tok)
		if err != nil {
			panic(err.Error())
		}
		usuarios = append(usuarios, usuario)
	}
	json.NewEncoder(w).Encode(usuarios)

	fmt.Println("ESTO ES GET USUARIOS")
}

/////////////// GET USUARIO POR ID //////////////////////
func getUsuario(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	params := mux.Vars(r)

	result, err := db.Query("SELECT * FROM usuarios WHERE id = ?", params["id"])
	if err != nil {
		panic(err.Error())
	}

	defer result.Close()

	var usuario Usuario

	for result.Next() {
		err := result.Scan(&usuario.Id, &usuario.Nombre, &usuario.Password, &usuario.Email, &usuario.Rol, &usuario.Tok)
		if err != nil {
			panic(err.Error())
		}
	}
	json.NewEncoder(w).Encode(usuario)

	fmt.Println("ESTO ES USUARIO PO ID")
}

/////////////////// POST USUARIO ////////////////////////
func postUsuario(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	stmt, err := db.Prepare("INSERT INTO usuarios(id, nombre, password, email, rol, tok) VALUES (?,?,?,?,?,?)")
	if err != nil {
		panic(err.Error())
	}
	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		panic(err.Error())
	}
	key := make(map[string]string)
	json.Unmarshal(body, &key)

	id := key["id"]
	nombre := key["nombre"]
	password := key["password"]
	email := key["email"]
	rol := key["rol"]
	tok := key["tok"]

	_, err = stmt.Exec(&id, &nombre, &password, &email, &rol, &tok)
	if err != nil {
		panic(err.Error())
	}

	fmt.Fprintf(w, "Se ha añadido un nuevo usuario")
	fmt.Println()
	fmt.Println("ESTO ES POST USUARIOS")
}

///////////////////// PUT USUARIO ///////////////////////
func putUsuario(w http.ResponseWriter, r *http.Request) {
	params := mux.Vars(r)

	stmt, err := db.Prepare("UPDATE usuarios SET id = ?, nombre = ?, password = ?, email = ?, rol = ?, tok = ? WHERE id = ?")
	if err != nil {
		panic(err.Error())
	}

	body, err := ioutil.ReadAll(r.Body)
	if err != nil {
		panic(err.Error())
	}

	key := make(map[string]string)
	json.Unmarshal(body, &key)

	newId := key["id"]
	newNombre := key["nombre"]
	newPassword := key["password"]
	newEmail := key["email"]
	newRol := key["rol"]
	newTok := key["tok"]

	_, err = stmt.Exec(&newId, &newNombre, &newPassword, &newEmail, &newRol, &newTok, params["id"])
	if err != nil {
		panic(err.Error())
	}
	fmt.Fprintf(w, "Se ha actualizado el usuario %s correctamente", params["id"])
	fmt.Println("ESTO ES UPDATE USUARIOS")
}

///////////////////// DELETE USUARIO //////////////////////
func deleteUsuario(w http.ResponseWriter, r *http.Request) {
	params := mux.Vars(r)

	stmt, err := db.Prepare("DELETE FROM usuarios WHERE id = ?")
	if err != nil {
		panic(err.Error())
	}

	_, err = stmt.Exec(params["id"])
	if err != nil {
		panic(err.Error())
	}

	fmt.Fprintf(w, "Se ha eliminado el usuario %s correctamente ", params["id"])
	fmt.Println("ESTO ES DELETE USUARIO")
}

////////////////////////////////// FIN API USUARIOS //////////////////////////////
