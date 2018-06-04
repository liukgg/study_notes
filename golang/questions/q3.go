package main

import (
	"log"
	"time"
)

func main() {
	var Ball int
	table := make(chan int)
	go player("2", table)
	go player("1", table)

	// 首先把球放到“桌上”
	table <- Ball
	time.Sleep(1 * time.Second)
	// 1s后比赛结束……
	<-table
}

func player(id string, table chan int) {
	for {
		ball := <-table
		log.Printf("%s got ball[%d]\n", id, ball)
		time.Sleep(50 * time.Millisecond)
		log.Printf("%s bounceback ball[%d]\n", id, ball)
		ball++
		table <- ball
	}
}
