# game
<pre>
git clone https://github.com/josephtseng-echo/game_paigow_by_skynet.git
cd game_paigow_by_skynet

git clone https://github.com/cloudwu/skynet.git
cd skynet
make 'PLATFORM' # PLATFORM can be linux, macosx, freebsd now

cd ../

./skynet/skynet games/paigow/config/demo.lua
</pre>

# dir
<pre>
./games/paigow
├── config
├── cservice
├── docs
├── logs
├── luaclib
├── lualib
├── run
├── service
└── test
</pre>
