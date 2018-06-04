
### scope vs lifetime
Don’t confuse scope with lifetime. The scope of a declaration is a region of the program text; it is a compile-time property. The lifetime of a variable is the range of time during execution when the variable can be referred to by other parts of the program; it is a run-time property.

### Can we use buffered channel as a queue within a single goroutine?
Novices are sometimes tempted to use buffered channels within a single goroutine as a queue, lured by their pleasingly simple syntax, but this is a mistake. Channels are deeply connected to goroutine scheduling, and without another goroutine receiving from the channel, a sender—and perhaps the whole program—risks be coming blocked forever. If all you need is a simple queue, make one using a slice.

### Goroutine leak
```go
     func mirroredQuery() string {
         responses := make(chan string, 3)
         go func() { responses <- request("asia.gopl.io") }()
         go func() { responses <- request("europe.gopl.io") }()
         go func() { responses <- request("americas.gopl.io") }()
         return <-responses // return the quickest response
     }
     func request(hostname string) (response string) { /* ... */ }
```

Had we used an unbuffered channel, the two slower goroutines would have gotten stuck trying to send their responses on a channel from which no goroutine will ever receive. This situation, called a goroutine leak, would be a bug . Unlike garbage variables, leaked goroutines are not automatically collected, so it is important to make sure that goroutines terminate themselves when no longer needed.

another example:

     // makeThumbnails4 makes thumbnails for the specified files in parallel.
     // It returns an error if any step failed.
     func makeThumbnails4(filenames []string) error {
         errors := make(chan error)
         for _, f := range filenames {
             go func(f string) {
                 _, err := thumbnail.ImageFile(f)
                 errors <- err
             }(f)
         }

         for range filenames {
             if err := <-errors; err != nil {
                 return err // NOTE: incorrect: goroutine leak!
             }
        }

        return nil 
    }

This f unc t ion has a subtle bug . When it encounters t he first non-ni l er ror, it retur ns t he er ror to t he c al ler, le av ing no gorout ine draining t he errors channel. E ach remaining worker gorout ine w i l l blo ck fore ver w hen it t r ies to s end a value on t hat channel, and w i l l ne ver ter minate. This situ at ion, a gorout ine le ak (§8.4.4), may c aus e t he w hole prog ram to get stuck or to run out of memory.

### Where to place wg.Wait() ?
     // makeThumbnails6 makes thumbnails for each file received from the channel.
     // It returns the number of bytes occupied by the files it creates.
     func makeThumbnails6(filenames <-chan string) int64 {
         sizes := make(chan int64)
         var wg sync.WaitGroup // number of working goroutines
         wg.Wait()

         for f := range filenames {
             wg.Add(1)
             // worker
             go func(f string) {
                 defer wg.Done()
                 thumb, err := thumbnail.ImageFile(f)
                 if err != nil {
                     log.Println(err)
                     return 
                 }
                 info, _ := os.Stat(thumb) // OK to ignore error
                 sizes <- info.Size()
             }(f)
         }

         // closer
         go func() {
             close(sizes)
         }()

         var total int64
         for size := range sizes {
             total += size
         }
         return total
     }

Observe how we create a closer goroutine that waits for the workers to finish b efore closing the sizes channel. These two operations, wait and close, must be concurrent with the loop over sizes. Consider the alternatives: if the wait operation were placed in the main goroutine before the loop, it would never end, and if placed after the loop, it would be unreachable since with nothing closing the channel, the loop would never terminate.

refer: Figure 8.5
