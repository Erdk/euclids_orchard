#include <iostream>
#include <cmath>

std::pair<unsigned, unsigned> euc(unsigned a, unsigned b, unsigned counter) {
  if (a == 0) {
    return std::make_pair(b, counter);
  } else if (b == 0) {
    return std::make_pair(a, counter);
  }

  if (a < b) {
    std::swap(a, b);
  }

  unsigned c = a % b;
  if (c != 0) {
    return euc(c, b, counter + 1);
  }

  return std::make_pair(b % a, counter + 1);
}

int main(int argc, const char* argv[]){
  for (int i = -4; i < 5; i++) {
    for (int j = -4; j < 5; j++) {
      unsigned k = 1;
      auto ret = euc(std::abs(i), std::abs(j), k);
      if (ret.first == 1) {
        std::cout << ret.second << "  ";
      } else {
        std::cout << "0  ";
      }
    }

    std::cout <<  "\n\n";
  }

  return 0;
}
