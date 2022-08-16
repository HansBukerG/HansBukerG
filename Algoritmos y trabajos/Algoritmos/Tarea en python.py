from os import system

contacto = []
lista_contactos = []
iterar_programa = True
contador_agenda = 1
print("Bienvenido al programa certamen 2")
print("Esta es una agenta única")

while True:
    print(" Menu principal")
    print(" 1 Registrar nuevo contacto")
    print(" 2 Ver Lista de Contactos")
    print(" 3 Buscar por Apellido")
    print(" 4 Modificar un contacto")
    print(" 5 Eliminar un contacto")
    print(" 6 Finalizar programa")

    opcion = int(input("Ïngrese una opcion: "))

    if 1 <= opcion <= 6:
        print("opcion ingresada es válida")
        if opcion == 1:
            system("cls")
            print("1 Registrar nuevo contacto")
            nombre_persona_ingreso = input("Ingrese nombre: ")
            apellido_persona_ingreso = input("Ingrese apellido: ")
            correo_persona_ingreso = input("Ingrese correo: ")
            flag = 1
            while flag == 1:
                telefono_persona_ingreso = input("Ingrese Telefono: ")
                try:
                    int(telefono_persona_ingreso)
                    flag = 0
                except ValueError:
                    print("Numero invalido")
                    flag = 1

            contacto = [contador_agenda,nombre_persona_ingreso, apellido_persona_ingreso, correo_persona_ingreso, telefono_persona_ingreso]
            print("Contacto a guardar: ")

            print(contacto)
            lista_contactos.append(contacto)
            contador_agenda += 1
            print("Contacto guardado con éxito: ")

        elif opcion == 2:
            system("cls")
            print("2 Ver Lista de Contactos")

            for contacto_contador in  lista_contactos :
                print(contacto_contador)

        elif opcion == 3:
            print("3 Buscar por Apellido")

            apellido_persona_buscar = input("Ingrese el apellido a buscar: ")

            for iterador_buscar in lista_contactos:
                if iterador_buscar[2] == apellido_persona_buscar:
                    print("Persona encontrada")
                    print(iterador_buscar)

        elif opcion == 4:
            print("4 Modificar un contacto")
            index_numero_buscar = int(input("Ingrese el numero del contacto que desee modificar: "))

            for iterador_modificar in lista_contactos:
                if iterador_modificar[0] == index_numero_buscar:
                    print("Contacto encontrado")
                    print(iterador_modificar)
                    flag_modificar = 1
                    while flag_modificar == 1:
                        print("     1 Nombre")
                        print("     2 Apellido")
                        print("     3 Correo")
                        print("     4 Numero Telefonico")
                        opcion_modificar = int(input("Seleccione el campo que desee modificar: "))
                        if 1 <= opcion_modificar <= 4:
                            if opcion_modificar == 1 :
                                nuevo_nombre = input("Ingrese nuevo nombre: ")
                                iterador_modificar[1] = nuevo_nombre
                                print("Contacto modificado con exito!")
                                print(iterador_modificar)
                                flag_modificar = 0
                            elif opcion_modificar == 2 :
                                nuevo_apellido = input("Ingrese nuevo apellido: ")
                                iterador_modificar[2] = nuevo_apellido
                                print("Contacto modificado con exito!")
                                print(iterador_modificar)
                                flag_modificar = 0
                            elif opcion_modificar == 3 :
                                nuevo_correo = input("Ingrese nuevo correo: ")
                                iterador_modificar[3] = nuevo_correo
                                print("Contacto modificado con exito!")
                                print(iterador_modificar)
                                flag_modificar = 0
                            elif opcion_modificar == 4 :
                                while flag_modificar_telefono == 1:
                                    nuevo_telefono = input("Ingrese nuevo Numero Telefonico: ")
                                    try:
                                        int(telefono_persona_ingreso)
                                        flag_modificar_telefono = 0
                                    except ValueError:
                                        print("Numero invalido")
                                        flag_modificar_telefono = 1

                                iterador_modificar[4] = nuevo_telefono
                                print("Contacto modificado con exito!")
                                print(iterador_modificar)
                                flag_modificar = 0
                        else:
                            print("Opcion incorrecta")
        elif opcion == 5:
            print("5 Eliminar un contacto")
            index_numero_eliminar = int(input("Ingrese el numero del contacto que desee eliminar: "))
            nueva_lista = []
            for iterador_eliminar in lista_contactos:
                if iterador_eliminar[0] == index_numero_eliminar:
                    print("Contacto eliminado con exito!")
                else:
                    nueva_lista.append(iterador_eliminar)
            lista_contactos = nueva_lista

        elif opcion == 6:
            print("6 Finalizar programa")
            break
        else:
            print("Opción no válida")
    else:
        print("Opcion ingresada no es válida")