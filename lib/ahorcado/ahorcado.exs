defmodule Juego.Ahorcado do
    def escogerP() do
        palabras = ["lenguaje", "computadora", "elixir", "programacion",
                    "estudiante", "aprendizaje","concentracion","colombia","consola"]
        Enum.random(palabras)
    end

    def start() do
        listaPalabras = escogerP()
        espacios = String.duplicate("_", String.length(listaPalabras)-2)
        wordUser = String.first(listaPalabras) <> espacios <> String.last(listaPalabras)
        intento = 0
        juego(wordUser, listaPalabras, intento, grafico())
    end

    def juego(wordJugador, listaPalabras, intento, dibujo) when wordJugador != listaPalabras and intento < 6 do
        IO.puts(dibujo)
        IO.puts(wordJugador)
        registroLetra = IO.gets("Ingresa una Letra : ") |> String.trim()
        if String.contains?(listaPalabras, registroLetra) do
            wordUser = palabraActualizada(wordJugador, registroLetra, listaPalabras)
            juego(wordUser, listaPalabras, intento, dibujo)
        else
            intento = intento + 1
            dibujo = dibujoActual(intento, dibujo)
            juego(wordJugador, listaPalabras, intento, dibujo)
        end
    end

    def juego(wordJugador, listaPalabras, _, _) when wordJugador == listaPalabras, do: {:Ganaste , listaPalabras}
    def juego(_, _, intento, dibujo) when intento == 6, do: {:Perdiste, dibujo}

    def palabraActualizada(wordJugador, registroLetra, listaPalabras) do
        cambiar = cambios(listaPalabras, registroLetra)
        validar(cambiar, length(cambiar), wordJugador)
    end

    def cambios(listaPalabra, registroLetra) do
        p_listaPalabra = String.codepoints(listaPalabra)
        Enum.filter(Enum.with_index(p_listaPalabra), fn(t) -> elem(t, 0) == registroLetra end)
    end


    def validar(p_cambios, total, wordJugador) when total > 0 do
        t = Enum.at(p_cambios, length(p_cambios)-total)
        efecto = String.codepoints(wordJugador)
        |> List.replace_at(elem(t,1), elem(t,0))
        |> Enum.join("")
        total = total - 1
        validar(p_cambios, total, efecto)
    end

    def validar(_, 0, efecto), do: efecto



    def grafico() do
        imag = """

         ___________
          |         |
          |
          |
          |
         _|_
         |   |______
         |          |
         |__________|

        """
        imag
      end

    def actualDibujo(intento, dibujo) when intento <= 6 do
        foto = dibujoActual(intento, dibujo)
        foto
    end

    def actualDibujo(intento, dibujo) when intento >= 6 do
        dibujo
    end

    def dibujoActual(intento, dibujo) do
        case intento do
          6 ->
            """
                ___________
                |         |
                |
                |
                |
               _|_
                |   |______
                |          |
                |__________|

            """
          5 ->
            """
            ___________
            |         |
            |         0
            |
            |
           _|_
            |   |______
            |          |
            |__________|

        """
          4 ->
            """
            ___________
            |         |
            |         0
            |         |
            |
           _|_
            |   |______
            |          |
            |__________|

        """
          3 ->
            """
            ___________
            |         |
            |         0
            |        /|
            |
           _|_
            |   |______
            |          |
            |__________|

        """
          2 ->
            """
            ___________
            |         |
            |         0
            |        /|\
            |
           _|_
            |   |______
            |          |
            |__________|

        """
          1 ->
            """
            ___________
            |         |
            |         0
            |        /|\
            |        /
           _|_
            |   |______
            |          |
            |__________|

        """
          0 ->
            """
            ___________
            |         |
            |         0
            |        /|\
            |        / \
           _|_
            |   |______
            |          |
            |__________|

        """
          _ -> dibujo
        end
      end

end

 Juego.Ahorcado.start




# 88888888ba  88888888888 88888888ba  88888888ba,   88  ad88888ba 888888888888 88888888888
# 88      "8b 88          88      "8b 88      `"8b  88 d8"     "8b     88      88
# 88      ,8P 88          88      ,8P 88        `8b 88 Y8,             88      88
# 88aaaaaa8P' 88aaaaa     88aaaaaa8P' 88         88 88 `Y8aaaaa,       88      88aaaaa
# 88""""""'   88"""""     88""""88'   88         88 88   `"""""8b,     88      88"""""
# 88          88          88    `8b   88         8P 88         `8b     88      88
# 88          88          88     `8b  88      .a8P  88 Y8a     a8P     88      88
# 88          88888888888 88      `8b 88888888Y"'   88  "Y88888P"      88      88888888888

#   ,ad8888ba,        db        888b      88        db        ad88888ba 888888888888 88888888888
# d8"'    `"8b      d88b       8888b     88       d88b      d8"     "8b     88      88
# d8'               d8'`8b      88 `8b    88      d8'`8b     Y8,             88      88
# 88               d8'  `8b     88  `8b   88     d8'  `8b    `Y8aaaaa,       88      88aaaaa
# 88      88888   d8YaaaaY8b    88   `8b  88    d8YaaaaY8b     `"""""8b,     88      88"""""
# Y8,        88  d8""""""""8b   88    `8b 88   d8""""""""8b          `8b     88      88
#  Y8a.    .a88 d8'        `8b  88     `8888  d8'        `8b Y8a     a8P     88      88
#   `"Y88888P" d8'          `8b 88      `888 d8'          `8b "Y88888P"      88      88888888888
