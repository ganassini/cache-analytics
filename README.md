# trabalho AOC simcache

[Github do simulador](https://github.com/toddmaustin/simplesim-3.0)

## TODO
    [ ] exp-1
        [x] write to csv file
        [x] go split benchmark
        [x] unified cache benchmark
        [ ] python script
        [ ] matplotlib
    [ ] exp-2
    [ ] exp-3
    [ ] exp-4
    [ ] exp-bonus

## Tutorial

```bash
 git clone https://github.com/ganassini/cache-sim
 cd cache-sim
 git clone https://github.com/toddmaustin/simplesim-3.0
 cd simplesim-3.0
 make config-pisa
 make
 cd ..
 vim run_exp_1.sh # modify $DIR variable in run_exp_1.sh to match the path
 ./run_exp_1.sh [gcc|go] [n_sets] [assoc]
```
