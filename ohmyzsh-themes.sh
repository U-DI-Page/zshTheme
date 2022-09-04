#!/bin/zsh

ThemeList=(
  robbyrussell
  af-magic
  afowler
  agnoster
  alanpeabody
  amuse
  apple
  arrow
  aussiegeek
  avit
  awesomepanda
  bira
  blinks
  bureau
  candy
  clean
  cloud
  crcandy
  crunch
  cypher
  dallas
  darkblood
  daveverwer
  dieter
  dogenpunk
  dpoggi
  dst
  dstuff
  duellj
  eastwood
  edvardm
  emotty
  essembeh
  evan
  fino-time
  fino
  fishy
  flazz
  fletcherm
  fox
  frisk
  frontcube
  funky
  fwalch
  gallifrey
  gallois
  garyblessington
  gentoo
  geoffgarside
  gianu
  gnzh
  gozilla
  half-life
  humza
  imajes
  intheloop
  itchy
  jaischeema
  jbergantine
  jispwoso
  jnrowe
  jonathan
  josh
  jreese
  jtriley
  juanghurtado
  junkfood
  kafeitu
  kardan
  kennethreitz
  kolo
  kphoen
  lambda
  linuxonly
  lukerandall
  macovsky
  maran
  mgutz
  mh
  michelebologna
  mikeh
  miloshadzic
  minimal
  mortalscumbag
  mrtazz
  murilasso
  muse
  nanotech
  nebirhos
  nicoulaj
  norm
  obraun
  peepcode
  philips
  pmcgee
  pygmalion
  re5et
  refined
  rgm
  risto
  rixius
  rkj-repos
  sammy
  simonoff
  simple
  skaro
  smt
  Soliah
  sonicradish
  sorin
  sporty_256
  steeef
  strug
  sunaku
  sunrise
  superjarin
  suvash
  takashiyoshida
  terminalparty
  theunraveler
  tjkirch
  tonotdo
  trapd00r
  wedisagree
  wezm
  wezm+
  wuffers
  xiong-chiamiov
  xiong-chiamiov-plus
  ys
  zhann
)

renderList(){
  clear;
  echo "Press j to upper, k to down, h to prePage, l to next page, q to exit";
  echo "-----------------------------"
  for ((i = 0; i < 10; i++)); do
    index=$[$1*$pageSize+$i];
    selectIndex=`expr $2 % $pageSize`;
    if [ $i = $selectIndex ]
    then
      echo $(tput setaf 4; tput setab 7; tput bold)$ThemeList[$index]$(tput sgr0);
    else
      echo "$ThemeList[$index]"
    fi
  done
}

updateZSHConfig(){
  # echo "current theme: $1 $ThemeList[$1]";
  sed -i 's/ZSH_THEME=".*"/ZSH_THEME="'$ThemeList[$1]'"/g' ~/.zshrc;
  exec zsh;
  clear;
}

initPanel(){
  while read -s -k 1 key
  do
    case $key in
      (j) currentIndex=$[$currentIndex+1];
        ;;
      (k) currentIndex=$[$currentIndex-1];
        if [ $currentIndex -lt 0 ]
        then
          currentIndex=0;
        fi
        ;;
      (l) currentPage=$[$currentPage+1];
        ;;
      (h) currentPage=$[$currentPage-1];
        if [ $currentPage -lt 0 ]
        then
          currentPage=0
        fi
        ;;
      (q) clear; exit 0;
        ;;
      ($'\n') updateZSHConfig $currentIndex;
        ;;
    esac
    renderList $currentPage $currentIndex;
  done
}

currentIndex=1;
pageSize=10;
currentPage=0;
renderList $currentPage $currentIndex
initPanel;


