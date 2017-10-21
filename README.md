# vk_hack

## Генерация модулей
Перед генерацией в **terminal** перейти в папку с проектом

Генерация экрана: `make screen modName=[SCREEN_NAME] -f module.make`

Генерация сервиса: `make service modName=[SERVICE_NAME] -f module.make`

## Разрешение конфликтов
При возникновении конфликтов в файле проекта рекомендуется установить утилиту mergepbx для их разрешения

Инструкция по установке:

В терминале
```
brew install mergepbx
cd path/ProjectFolder`
open ~/.gitconfig
```

2.   Добавить следующие строки в файл конфигурации
```
#driver for merging Xcode project files
[mergetool "mergepbx"]
	cmd = mergepbx "$BASE" "$LOCAL" "$REMOTE" -o "$MERGED"
```

3.   Снова в терминале
`git mergetool --tool=mergepbx InSearch.xcodeproj/project.pbxproj`

4.   Успех!

5.   Иногда возникают ситуации, когда merge tool отработала хорошо, но xcode пишет ошибку, что файлы не может найти, тогда нужно

Перейти в Project->Build Phases->Compile Sources

Там можно будет увидеть вылетевшие из проекта файлы и просто удалить(определить их можно по отсутствию иконки), также нужно будет проверить Copy Bundle Resources, там отвалившиеся xib-ы могут быть

