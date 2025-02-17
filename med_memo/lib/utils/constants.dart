enum Constants {
  reminderScreenPageTitle('Lembretes'),
  reminderScreenTitle('Organize sua Rotina de Medicação e Evite Erros Comuns'),
  reminderScreenDescription('Gerencie seus horários de medicação com ferramentas simples, como alarmes ou aplicativos. Estabeleça uma rotina fixa e utilize lembretes visuais para evitar esquecimentos ou doses duplicadas. Assim, você garante o tratamento adequado e a adesão correta.'),
  reminderScreenDeleteMessage('excluído'),
  reminderScreenEmptyMessage('Não há registros'),

  addReminderScreenTitle('Criar Lembrete'),
  addReminderScreenTime('Horário'),
  addReminderScreenMedication('Medicação'),
  addReminderScreenMedicationHint('Adicione o nome da medicação'),
  addReminderScreenMedicationError('Por favor, adicione o nome da medicação'),
  addReminderScreenDosage('Dosagem'),
  addReminderScreenDosageHint('Adicione a dosagem'),
  addReminderScreenDosageError('Por favor, adicione a dosagem'),
  addReminderScreenAddButton('Salvar medicação'),
  addReminderScreenSuccessMessage('Lembrete criado com sucesso!'),
  addReminderScreenOKButton('OK'),


  unknown('unknown');


  final String label; // define a private field

  const Constants(this.label); // constructor

  static Constants fromString(String label) { // static parser method
    return values.firstWhere(
      (v) => v.label == label,
      orElse: () => Constants.unknown,
    );
  }
}