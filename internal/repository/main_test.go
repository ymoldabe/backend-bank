package repository

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

var testQueries *Queries

const (
	driver   = "postgres"
	dbSource = "postgresql://root:secret@localhost:5432/bank?sslmode=disable"
)

func TestMain(m *testing.M) {
	conn, err := sql.Open(driver, dbSource)
	if err != nil {
		log.Fatalf("fail conn db:%s", err.Error())
	}

	testQueries = New(conn)

	os.Exit(m.Run())
}
