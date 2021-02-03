
Option Explicit
Option Release          'On/Off default:On  release or debug
Option Console          'On/Off default:On  console or gui  
Option Preserve         'On/Off default:On  preserve temporary .cpp/.o/.h files
Option Verbose          'On/Off default:On  show g++ compiling commands
Option Dll              'On/Off default:On  for make .dll/.so/.dylib 

Option LD_FLAGS  "  -lSystem "   'link libSystem.a
Option CPP_FLAGS "  -std=c++17 "