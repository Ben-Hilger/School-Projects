package main

import (
	"context"
	"crypto/ecdsa"
	"math/big"
	"net/http"
	"os"
	"strings"

	"github.com/Ben-Hilger/todo-etherium/api"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	client, err := ethclient.Dial("http://127.0.0.1:8545")
	if err != nil {
		panic(err)
	}
	privateKeyStr := os.Getenv("PRIVATEKEY")
	conn, err := api.NewApi(common.HexToAddress(privateKeyStr), client)
	if err != nil {
		panic(err)
	}
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.PATCH("/list/:date", func(c echo.Context) error {
		date := c.Param("date")
		name := c.FormValue("name")
		doneString := strings.ToLower(c.FormValue("done"))
		done := doneString == "true" || doneString == "1"
		reply, err := conn.Done(getSigned(client), date, name, done)
		if err != nil {
			return err
		}
		return c.JSON(http.StatusOK, reply)
	})
	e.POST("/list/:date", func(c echo.Context) error {
		date := c.Param("date")
		name := c.FormValue("name")
		reply, err := conn.AddToDoList(getSigned(client), name, date)
		if err != nil {
			return err
		}
		return c.JSON(http.StatusOK, reply)
	})
	e.GET("/list/:date", func(c echo.Context) error {
		date := c.Param("date")
		println(date)
		reply, err := conn.GetAll(&bind.CallOpts{From: getSigned(client).From})
		if err != nil {
			return err
		}
		return c.JSON(http.StatusOK, reply)
	})

	e.Logger.Fatal(e.Start(":8080"))
}

func getSenderAddress() (common.Address, *ecdsa.PrivateKey) {
	privateKey, err := crypto.HexToECDSA("f34f9aea3485a2f66e2d094d2e1d3fed891d0847b5adb4a8d3f290a54d4b3cfc")
	if err != nil {
		panic(err)
	}

	publicKey := privateKey.Public()
	publicKeyECDSA, ok := publicKey.(*ecdsa.PublicKey)
	if !ok {
		panic("invalid key")
	}

	return crypto.PubkeyToAddress(*publicKeyECDSA), privateKey

}

func getSigned(client *ethclient.Client) *bind.TransactOpts {
	fromAddress, privateKey := getSenderAddress()
	nonce, err := client.PendingNonceAt(context.Background(), fromAddress)
	if err != nil {
		panic(err)
	}

	chainID, err := client.ChainID(context.Background())
	if err != nil {
		panic(err)
	}
	auth, err := bind.NewKeyedTransactorWithChainID(privateKey, chainID)
	if err != nil {
		panic(err)
	}
	auth.Nonce = big.NewInt(int64(nonce))

	return auth
}
