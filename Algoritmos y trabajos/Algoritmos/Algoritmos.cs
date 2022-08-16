using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Test_Pruebas_Tecnicas.Algoritmos
{
    class Algoritmos
    {

        public bool ejecutarTest(int opcion) {
            bool salida = true;
            try
            {
                switch (opcion)
                {
                    case 1:
                        salida = InvertirPalabraTest();
                        break;
                    case 2:
                        salida = CuantasVecesSeRepiteUnCaracterTest();
                        break;
                    case 3:
                        salida = AlgoritmoFizzBuzzTest();
                        break;
                }
                
            }
            catch (Exception)
            {
                Console.WriteLine("Error de ejecución de Algoritmo: " + opcion);
                salida = false;
                throw;
            }
            return salida;
        }

        
        private String InvertirPalabra(String Palabra)
        {
            //Este algoritmo sirve para invertir una palabra, recibe como parámetro de entrada una cadena y retorna esta misma, pero invertida
            String Palabra_Invertida;
            Palabra_Invertida = new String(Palabra.Reverse().ToArray());
            return Palabra_Invertida;
        }

        private String CuantasVecesSeRepiteUnCaracter(String Palabra)
        {
            //Este algoritmo ejecuta un contador por cada palabra en una cadena y cuenta cuantas veces se repite un caracter
            int contador = 0;
            String PalabrasUnicas = "";

            foreach (char caracter1 in Palabra)
            {
                //Console.WriteLine("caracter actual: " + caracter1);
                foreach (char caracter2 in PalabrasUnicas)
                {
                    if (caracter1 == caracter2)
                        contador++;

                }
                //Console.WriteLine("contador: " + contador);
                if (contador == 0)
                {
                    PalabrasUnicas += caracter1.ToString();
                }
                contador = 0;
            }

            foreach (char caracter1 in PalabrasUnicas)
            {
                foreach (char caracter2 in Palabra)
                {
                    if (caracter1 == caracter2)
                        contador++;

                }
                Console.WriteLine("caracter actual: " + caracter1 + " contador: " + contador);
                contador = 0;
            }
            return PalabrasUnicas;
        }


        private void AlgoritmoFizzBuzz(int largo)
        {
            // FizzBuzz.
            //  Si el numero es multiplo de 3 se escribe Fizz. 
            //  Si el numero es multiplo de 5 se escribe Buzz.
            //  Si el número es múltiplo de ambos se escribe FizzBuzz.
            //  En caso contrario solo se imprime el valor del contador
            for (int contador = 0; contador < largo; contador++)
            {
                if (contador % 3 == 0 && contador % 5 == 0)
                {
                    Console.WriteLine("FizzBuzz");
                }
                else
                {
                    if (contador % 3 == 0)
                    {
                        Console.WriteLine("Fizz");

                    }
                    else
                    {
                        if (contador % 5 == 0)
                        {
                            Console.WriteLine("Buzz");
                        }
                        else
                        {
                            Console.WriteLine(contador);
                        }
                    }

                }
            }
        }
        public bool InvertirPalabraTest() {
            //Este método es de prueba, en caso de que su ejecución sea exitosa, retorna true, en caso contrario false.
            //Solamente se debe modificar el parámetro Texto_test;

            String Texto_test = "prueba de ejecución";

            bool retorno = true;
            try
            {
                Console.WriteLine("La palabra obtenida es: " + InvertirPalabra(Texto_test));
            }
            catch (Exception)
            {
                retorno = false;
                throw;
            }
            return retorno;
        }

        public bool CuantasVecesSeRepiteUnCaracterTest()
        {
            //Este método es de prueba, en caso de que su ejecución sea exitosa, retorna true, en caso contrario false.
            //Solamente se debe modificar el parámetro Texto_test;
            
            String Texto_test = "Este es un texto de pruebas para contar cada palabra contenida en este párrafo";

            bool retorno = true;
            try
            {
                Console.WriteLine("La palabra obtenida es: " + CuantasVecesSeRepiteUnCaracter(Texto_test));
            }
            catch (Exception)
            {
                retorno = false;
                throw;
            }
            return retorno;
        }

        public bool AlgoritmoFizzBuzzTest() 
        {
            //Esta es la instancias de pruebas del algoritmo de FizzBuzz
            //Debes modificar el contenido del campo largo.
            int largo = 99;
            bool salida = true;

            try
            {
                AlgoritmoFizzBuzz(largo);
                salida = true;
                
            }
            catch (Exception)
            {
                Console.WriteLine("Error de ejecución.");
                salida = false;
                throw;
            }
            return salida;
        }
    }
}
