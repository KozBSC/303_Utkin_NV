<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Форма для обновления информации о дантисте</title>
    <link rel="stylesheet" href="../styles/style.css">
</head>
<body>
<?php
require_once 'DentistRepository.php';
$repository = DentistRepository::getInstance();
$dentist = count($_POST) == 0 ? $repository->readDentistById($_GET['dentist_id']) : $_POST;
$dentist['birthday'] = date_format(new DateTime($dentist['birthday']), 'Y-m-d');
?>

<form method="post" action="" enctype="application/x-www-form-urlencoded">
    <H1>Форма для обновления информации о дантисте</H1>
    <fieldset class="fs">
        <legend>Личная информация о дантисте</legend>
        <input type="hidden" name="id" value=<?= $dentist['id'] ?>>
        <p><label>Фамилия:<input name="last_name" class="user-label" value=<?= $dentist['last_name'] ?>></label></p>
        <p><label>Имя:<input name="first_name" class="user-label" value=<?= $dentist['first_name'] ?>></label></p>
        <p><label>Отчество:<input name="middle_name" class="user-label" value=<?= $dentist['middle_name'] ?>></label>
        </p>
        <p><label>Дата рождения:<input type="date" name="birthday" class="user-label" value=<?= $dentist['birthday'] ?>></label>
        </p>
    </fieldset>
    <fieldset class="fs">
        <legend>Специализация дантиста</legend>
        <?php foreach ($repository->readSpecializations() as $item): ?>
            <?php if ($item['id'] == $dentist['specialization_id']): ?>
                <p><label> <input type="radio" name="specialization_id"
                                  value="<?= $item['id'] ?>" checked> <?= $item['specialization'] ?> </label></p>
            <?php else: ?>
                <p><label> <input type="radio" name="specialization_id"
                                  value="<?= $item['id'] ?>"> <?= $item['specialization'] ?> </label></p>
            <?php endif; ?>
        <?php endforeach; ?>
    </fieldset>
    <fieldset class="fs">
        <legend>Статус дантиста</legend>
        <?php foreach ($repository->readStatuses() as $item): ?>
            <?php if ($item['id'] == $dentist['employee_status_id']): ?>
                <p><label> <input type="radio" name="employee_status_id" value="<?= $item['id'] ?>"
                                  checked> <?= $item['status'] ?>
                    </label>
                </p>
            <?php else: ?>
                <p><label> <input type="radio" name="employee_status_id"
                                  value="<?= $item['id'] ?>"> <?= $item['status'] ?> </label>
                </p>
            <?php endif; ?>
        <?php endforeach; ?>
    </fieldset>
    <p><label>Процент выручки: <input type="number" min="1" max="100" name="earning_in_percent"
                                      value="<?= $dentist['earning_in_percent'] ?>"></label></p>
    <p>
        <button class="def_button" type="submit">Сохранить в базе данных</button>
    </p>
</form>
<?php if (isset($_POST['last_name']) && isset($_POST['first_name']) && isset($_POST['middle_name']) && isset($_POST['birthday']) && isset($_POST['specialization_id']) && isset($_POST['employee_status_id']) && isset($_POST['earning_in_percent']) &&
    $_POST['last_name'] != '' && $_POST['first_name'] != '' && $_POST['middle_name'] != '' && $_POST['birthday'] != '' && $_POST['specialization_id'] != '' && $_POST['employee_status_id'] != '' && $_POST['earning_in_percent'] != '') : ?>
    <?php
    $_POST['birthday'] = date_format(new DateTime($_POST['birthday']), 'd.m.Y');
    $repository->updateDentist($_POST);
    ?>
    <p>Обновление информации в базе данных прошло успешно</p>
<?php elseif (count($_POST) != 0): ?>
    <p>Обновление информации в базе данных не удалось</p>
<?php endif; ?>
<button onclick="window.location.href = '../index.php';" class="def_button">Назад</button>
</body>
</html>
